package exercise

import (
	"github.com/dikderoy/imagen/drawer"
	_ "github.com/sirupsen/logrus"
	"image/color"
)


type Mandelbrot struct{
	iterations int
	scaleFactor float32
	offsetX, offsetY float32
}

func NewMandelbrot(iterations int, scaleFactor float32, offsetX, offsetY float32) drawer.MandelbrotGenerator {
    return Mandelbrot{iterations, scaleFactor, offsetX, offsetY}
}

func (mandelbrot Mandelbrot) Generate(canvas *drawer.Image) error {

  limit := float32(4)
  halfWidth := canvas.Width / 2
  halfHeight := canvas.Height / 2

  for y := -halfHeight; y <= halfHeight; y++ {

    Yn := mandelbrot.offsetY + (float32(y) * mandelbrot.scaleFactor)

    for x := -halfWidth; x < halfWidth; x++ {

      Xn := mandelbrot.offsetX + (float32(x) * mandelbrot.scaleFactor)
      var Xn_1 float32 = Xn
      var Yn_1 float32 = Yn
      numIterations := 0
      for ; numIterations < mandelbrot.iterations; {
	numIterations++
	Xn_2 := Xn_1 * Xn_1 - Yn_1 * Yn_1 + Xn
	Yn_2 := 2 * Xn_1 * Yn_1 + Yn
	if (Xn_2 * Xn_2) + (Yn_2 * Yn_2) > limit {
	  break
	}
	Xn_1 = Xn_2
	Yn_1 = Yn_2
      }
      var col = uint8(0)
      if numIterations < mandelbrot.iterations {
	col = 255
      }
     canvas.Set(x+halfWidth, y+halfHeight, color.RGBA{col,col,col,255}) 
    }
  }
  return nil
}

type Point struct{
  x int
  y int
  col uint8
}

func (mandelbrot Mandelbrot) GenerateParallel(canvas * drawer.Image) error {
  halfHeight := canvas.Height / 2
  halfWidth := canvas.Width / 2
  channel := make(chan Point, canvas.Width * canvas.Height)
  for y := -halfHeight; y <= halfHeight; y++ {
	go drawSetsForY(y,mandelbrot,canvas, channel)
  }
  for i := 0 ; i < canvas.Width * canvas.Height; i++ {
     point := <- channel
     col := point.col
     canvas.Set(point.x+halfWidth, point.y+halfHeight, color.RGBA{col,col,col,255})
  }
  return nil
}

func drawSetsForY(y int, mandelbrot  Mandelbrot, canvas * drawer.Image, channel chan Point){
  halfWidth := canvas.Width / 2
  limit := float32(4)
  Yn := mandelbrot.offsetY + (float32(y) * mandelbrot.scaleFactor)
  for x := -halfWidth; x < halfWidth; x++ {
      Xn := mandelbrot.offsetX + (float32(x) * mandelbrot.scaleFactor)
      var Xn_1 float32 = Xn
      var Yn_1 float32 = Yn
      numIterations := 0
      for ; numIterations < mandelbrot.iterations; {
	numIterations++
	Xn_2 := Xn_1 * Xn_1 - Yn_1 * Yn_1 + Xn
	Yn_2 := 2 * Xn_1 * Yn_1 + Yn
	if (Xn_2 * Xn_2) + (Yn_2 * Yn_2) > limit {
	  break
	}
	Xn_1 = Xn_2
	Yn_1 = Yn_2
      }
      var col = uint8(0)
      if numIterations < mandelbrot.iterations {
	col = 255
      }
      var point Point
      point.x = x
      point.y = y
      point.col = col
      channel <- point
  }
}
