package exercise

import (
	"github.com/dikderoy/imagen/drawer"
	log "github.com/sirupsen/logrus"
	"image/color"
	"math/rand"
	"time"
	"sync"
)

type MandelbrotGen struct {
	iterations	int
	scaleFactor float32
	offsetX		float32
	offsetY		float32
}

func NewMandelbrot(iterations int, scaleFactor float32, offsetX, offsetY float32) drawer.MandelbrotGenerator {
	return MandelbrotGen{iterations, scaleFactor, offsetX, offsetY}
}

func (mbro MandelbrotGen) CalCol(ix,iy float32, cbase float32) color.Color {
	x := float32(0)
	y := float32(0)
	
	var r,b,g uint8
	
	for i := 0; i < mbro.iterations; i++ {
		x, y = x*x - y*y + ix, 2 * x * y + iy
		
		if x*x + y*y > 4 {
			return color.Black
		}
	}
	
	mod := x * x + y * y
	r,g,b = uint8(cbase * mod * 2), uint8(cbase * mod * 5), uint8(cbase * mod * 10)
	
	return color.RGBA{r,g,b,255}
}

func (mbro MandelbrotGen) Generate(canvas *drawer.Image) error {
	rand.Seed(time.Now().UnixNano())
	rmin, rmax := 15, 250
	rset := rmin + rand.Intn(rmax+1)
	
	roff := rand.Float32()
	log.WithField("roffset", roff).Info("randomly generated offset factor")
	roffx := roff * mbro.offsetX
	roffy := roff * mbro.offsetY
	
	for x := 0; x < canvas.Width; x++ {
		rx := (float32(x)/float32(canvas.Width)) / mbro.scaleFactor - roffx
	
		for y := 0; y < canvas.Height; y++ {
			ry := (float32(y)/float32(canvas.Height)) / mbro.scaleFactor - roffy
			
			canvas.Set(x,y,mbro.CalCol(rx,ry,float32(rset)))
		}
	}
	
	return nil
}

func (mbro MandelbrotGen) GenerateParallel(canvas *drawer.Image) error {
	wg := sync.WaitGroup{}
	
	rand.Seed(time.Now().UnixNano())
	rmin, rmax := 15, 250
	rset := rmin + rand.Intn(rmax+1)
	
	roff := rand.Float32()
	log.WithField("roffset", roff).Info("randomly generated offset factor")
	roffx := roff * mbro.offsetX
	roffy := roff * mbro.offsetY
	
	for x := 0; x < canvas.Width; x++ {
		rx := (float32(x)/float32(canvas.Width)) / mbro.scaleFactor - roffx
		
		for y := 0; y < canvas.Height; y++ {
			ry := (float32(y)/float32(canvas.Height)) / mbro.scaleFactor - roffy
			
			wg.Add(1)
			
			go func(x,y int) {
				canvas.Set(x,y,mbro.CalCol(rx,ry,float32(rset)))
				wg.Done()
			}(x,y)
		}
	}
	
	return nil
}

