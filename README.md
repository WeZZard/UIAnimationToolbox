# UIAnimationToolbox

[![Build Status](https://travis-ci.com/WeZZard/UIAnimationToolbox.svg?branch=master)](https://travis-ci.com/WeZZard/UIAnimationToolbox)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

[中文](./使用說明.md)

Make use of advanced Core Animation feture without leaving UIKit.

## Highlights

- Shift animations timing with a nest-able one-line API.

  ```swift
  UIView.animate(withDuration: 0.3) {
      /* Animations without timing shifting */
      UIView.shiftAnimationsTiming(speed: 0.5) {
          /* Timing shifted animations */
      }
  }
  ```

  You can also shift other properties on `CAMediaTiming`.

- Custom view property animations with less effort.

- Interpolate UIKit animations with a single-line API.

  ```swift
  UIView.animate(withDuration: 0.3) {
      /* Install animations */
      UIView.addAnimationInterpolator { (progress) in
          /* Do your works with animation's progress */
      }
  }
  ```

- Evaluate `CAMediaTimingFunction`'s `y` value with Newton-Raphson method.

- Enables additive animation in Core Animation level with less effort.

## Usages

Notes: You can gain a deep understanding of the framework by reading the
category app in this project.

### Shift Animation's Timing

The framework hooked up into the whole process of the installations of
UIKit block animations and spring animations, thus it can shifting
animations timing on-the-fly.

<img src="https://github.com/WeZZard/UIAnimationToolbox/raw/master/.readme.d/animations-timing-example.gif" alt="Animations Timing" width="375px">

See detailed usages of `CAMediaTiming` on
[Controllign Animation Timing](http://ronnqvi.st/controlling-animation-timing)
by David Rönnqvist, or you can use the beautiful
[cheat-sheet](http://ronnqvi.st/images/CAMediaTiming%20cheat%20sheet.pdf)
done by him.

### Custom View Property Animations with Less Effort

Traditional custom property animations solutions like those mentioned in
[Animating Custom Layer Properties](https://www.objc.io/issues/12-animations/animating-custom-layer-properties/)
encourages you to assemble `CAAnimation` objects and then return them in
`CALayer.action(forKey:)` which is tedious and imperfect in current
spring-animation days, because you almost cannot assemble a
`CASpringAnimation` object perfectly like those created by UIKit API.

UIAnimationToolbox takes over the control of the installations of block
animations and spring animations and gives you an opportunity to get
animation objects which is totally the same to those created by UIKit API.

You only have to offer the animated property in your backward layer of the
view.

```swift
class Layer: CALayer {
    @NSManaged
    var animatedProperty: CGFloat

    override class func needsDisplay(forKey key: String) -> Bool {
        switch key {
        case "animatedProperty":    return true
        default:                    return super.needsDisplay(forKey: key)
        }
    }
}
```

Then build the relationship between the backward layer and the view

```swift
class View: UIView {
    var animatedProperty: CGFloat {
        get { return _layer.hour }
        set { _layer.hour = newValue }
    }

    override class var layerClass: AnyClass {
        return Layer.self
    }

    var _layer: Layer { return layer as! Layer }

    init(animatedProperty: CGFloat) {
        super.init(frame: .zero)
        self.animatedProperty = animatedProperty
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        animatedProperty = 0
    }

    override func draw(_ rect: CGRect) {
        let presentationLayer = _layer.presentation() ?? _layer

        // Do things with `presentationLayer.animatedProperty`
    }
}
```

Finally do the magic.

```swift
class View: UIView {
    ...

    override func action(for layer: CALayer, forKey event: String) -> CAAction? {
        switch event {
        case "animatedProperty":
            return UIAnimationActionInferred(layer: layer, event: event)
        default:
            return super.action(for: layer, forKey: event)
        }
    }

    ...
}
```

`UIAnimationActionInferred` can help you infer a `CAAnimation` object when
you set the view's `animatedProperty` inside a UIKit block animation block
or spring animation block. When you are out of those blocks, it does
nothing and all things goes like setting a view's `frame` or `alpha`.

Plus, for properties of type `CGRect`, `CGSize`, `CGPoint`, `CGVector`,
`CATransform3D`, `CGFloat`, `Double` and `Float`, they enjoys additive
animations by default.

### Interpolate UIKit Animations

The framework also can interpolate UIKit block animations and spring
animations. You can use this API to synchronize UIKit block animations and
spring animations with your custom animated stuffs (such as voice volumne).

```swift
UIView.animate(withDuration: 2.0) {
    // ...
    UIView.addAnimationInterpolator { (progress) in
        // ...
    }
}
```

<img src="https://github.com/WeZZard/UIAnimationToolbox/raw/master/.readme.d/interpolate-block-animations-example.gif" alt="Interpolate Block Animations" width="375px">

```swift
UIView.animate(withDuration: 2.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.2, options: []) {
    // ...
    UIView.addAnimationInterpolator { (progress) in
        // ...
    }
}
```

<img src="https://github.com/WeZZard/UIAnimationToolbox/raw/master/.readme.d/interpolate-spring-animations-example.gif" alt="Interpolate Spring Animations" width="375px">

Of course, you can also nest an animation interpolator in a timing
shifting closure. The following animation interpolator gets started to
work in 1.0s later than the animations installed by the parent animation
block began.

```swift
UIView.animate(withDuration: 2.0) {
    // ...
    UIView.shiftAnimationsTiming(beginTime: 1.0, fillMode: .forwards) {
        // ...
        UIView.addAnimationInterpolator { (progress) in
            // ...
        }
    }
}
```

### Evaluate CAMediaTimingFunction's Y Value

`CAMediaTimingFunction` is a black-box to much developers, but the theory
behind this class is quite simple - bezier path. We can evaluate
`CAMediaTimingFunction`'s y value by using Newton-Raphson method which may
be taught on math courses of most colleges. I encapsulated the whole
process within the function `CAMediaTimingFunction.evaluteY(forX:)`.

Evaluating `CAMediaTimingFunction`'s y value enables you to easily gain a
beautiful performance when building animations with `CADisplayLink` or
customized experience when tuning voice volumn by interpolating
`CAMediaTimingFunction`.

### Enables Additive Animation in Core Animation Level with Less Effort

The framework ships with a generic class `AdditiveAnimationAction<Animation>`
which rewrite non-additive animations into additive animations. You can
create `AdditiveAnimationAction` with an animation pending to be rewritten
and then call `AdditiveAnimationAction.run(forKey: "animationKey", object: layer, arguments: nil)`
to add the rewritten animation to a `layer` for `"animationKey"`.

## Todos

- [ ] Keyframe animations support.

## License

MIT
