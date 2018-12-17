package main

import (
	"github.com/dikderoy/imagen/drawer"
	"github.com/dikderoy/imagen/exercise"
	log "github.com/sirupsen/logrus"
	"os"
)

func main() {
	drawer.Init()
	log.Info("starting, trying to open file")
	f, err := os.OpenFile("mandelbrot-sample.png", os.O_CREATE|os.O_TRUNC|os.O_WRONLY, 0644)
	if err != nil {
		log.WithError(err).Fatal("cannot create/open file for writing")
	}
	defer f.Close()

	log.Info("starting calculations")
	i := drawer.NewImage(drawer.GlobalConfig.Image.Resolution, drawer.GlobalConfig.Image.Resolution)
	log.WithField("scale-factor", drawer.GlobalConfig.Algorithm.ScaleFactor).Debug("chosen factor")
	log.WithField("resolution", drawer.GlobalConfig.Image.Resolution).Debug("chosen Resolution")
	log.WithField("offset-x", drawer.GlobalConfig.Image.Offset.X).Debug("chosen Offset X")
	log.WithField("offset-y", drawer.GlobalConfig.Image.Offset.Y).Debug("chosen Offset Y")
	m := exercise.NewMandelbrot(
		drawer.GlobalConfig.Algorithm.Iterations,
		float64(drawer.GlobalConfig.Algorithm.ScaleFactor),
		float64(drawer.GlobalConfig.Image.Offset.X),
		float64(drawer.GlobalConfig.Image.Offset.Y),
	)

	if drawer.GlobalConfig.Algorithm.Parallel {
		m.GenerateParallel(i)
	} else {
		m.Generate(i)
	}
	log.Info("done calculation, writing to file")
	err = i.Draw(f)
	if err != nil {
		log.WithError(err).Fatal("failed generate image")
	}
	log.Info("done!")
}
