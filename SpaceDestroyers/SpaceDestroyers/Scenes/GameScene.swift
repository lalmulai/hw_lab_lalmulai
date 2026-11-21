import SpriteKit
import GameplayKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {

    let rowsOfInvaders = Constants.Invader.rows
    var invaderSpeed = Constants.Invader.initialSpeed
    let leftBounds = Constants.Layout.leftBounds
    var rightBounds = Constants.Layout.rightBounds
    var invadersWhoCanFire: [Invader] = []
    let player: Player = Player()
    let maxLevels = Constants.Game.maxLevels

    let motionManager: CMMotionManager = CMMotionManager()
    var accelerationX: CGFloat = 0.0
}
