package exercise

import (
    "github.com/dikderoy/imagen/drawer"
    //log "github.com/sirupsen/logrus"
    "image/color"
    "sync"
    "math/cmplx"
)

type Mandelbrot struct {
    iterations  int
    scaleFactor float32
    offsetX     float32
    offsetY     float32
}

func NewMandelbrot(iterations int, scaleFactor float32, offsetX, offsetY float32) drawer.MandelbrotGenerator {
    return Mandelbrot { iterations, scaleFactor, offsetX, offsetY }
}

func (mandelbrot Mandelbrot) Generate(canvas *drawer.Image) error {
    for i := 0; i < canvas.Height; i++ {
        y := mandelbrot.scaleFactor * (float32(i) - float32(canvas.Height)/2.0) - mandelbrot.offsetY

        for j := 0; j < canvas.Width; j++ {
            x := mandelbrot.scaleFactor * (float32(j) - float32(canvas.Width)/2.0) - mandelbrot.offsetX
            canvas.Set(j, i, mandelbrot.GenerateColorRGB(x,y))
        }
    }

    return nil
}

func (mandelbrot Mandelbrot) GenerateParallel(canvas *drawer.Image) error {
    var waitGroup sync.WaitGroup

    for i := 0; i < canvas.Height; i++ {
        y := mandelbrot.scaleFactor * (float32(i) - float32(canvas.Height)/2.0) - mandelbrot.offsetY

        waitGroup.Add(1)
        go func(i int) {
            for j := 0; j < canvas.Width; j++ {
                x := mandelbrot.scaleFactor * (float32(j) - float32(canvas.Width)/2.0) - mandelbrot.offsetX
                canvas.Set(j, i, mandelbrot.GenerateColorRGB(x,y))
            }
            waitGroup.Done()
        }(i)
    }

    waitGroup.Wait()
    return nil
}

func (mandelbrot Mandelbrot) GenerateColor(x, y float32) color.Color {
    x1 := float32(0)
    y1 := float32(0)

    for iter := 0; iter < mandelbrot.iterations; iter++ {
        tmp := x1*x1 - y1*y1 + x
        y1 = 2.0*x1*y1 + y
        x1 = tmp
        if x1*x1 + y1*y1 > 4 {
            return color.RGBA { 255 - 20*uint8(iter), 255 - 20*uint8(iter), 255 - 20*uint8(iter), 255 }
        }
    }

    return color.Black
}

func (mandelbrot Mandelbrot) GenerateColorRGB(x, y float32) color.Color {
    base := complex128(complex(x, y))
    var curr complex128

    for iter := uint8(0); iter < uint8(mandelbrot.iterations); iter++ {
        curr = cmplx.Pow(complex128(curr), 2) + base
        if cmplx.Abs(curr) > 2 {
            return color.RGBA { 200, 255 - (40*iter) % 255, 255 - (40*iter) % 255, 255 }
        }
    }

    return color.Black
}

