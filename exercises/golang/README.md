## Solutions

I've already solved some tasks from Donovan's The Go Programming
Language. You can find the solutions here: 

https://github.com/qezz/go-course/tree/master/donovan-tgpl

The Mandelbrot solution is ch3/ex-3.5, ex-3.6

More generic solution with supersampling and different fractals is:
https://github.com/qezz/go-course/blob/master/donovan-tgpl/ch3/ex-3.7/main.go

## Demos

You can actually try it out live:

* Simple Mandelbrot: https://ancient-caverns-79291.herokuapp.com/frac
* Mandelbrot with params: https://ancient-caverns-79291.herokuapp.com/frac?height=1000&width=1000&ss=3&xmax=-1&ymax=0.5&ymin=-0.5
* Fractal function is also can be changed, just add `f=newton` to get Newton's fractal: https://ancient-caverns-79291.herokuapp.com/frac?f=newton&&ss=1

Options:

* `f` - fractal function, `mandelbrot | newton`
* `height`, `width` - the size of the generated image
* `xmax`, `xmin`, `ymax`, `ymin` shapes the squared relative region to render. It is possible to go much deeper.
* `ss` - super sampling grid, `ss=X` means that grid `X by X` will be generated for every output pixel

## Other

Other demos also have different options, check it out here: https://ancient-caverns-79291.herokuapp.com/

## Info

before trying to compile move current directory under $GOPATH

    mv ./golang $GOPATH/src/github.com/dikderoy/imagen

then use dep in `$GOPATH/src/github.com/dikderoy/imagen`

    dep ensure

this will install dependencies
