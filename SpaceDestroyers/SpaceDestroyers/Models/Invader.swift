import SpriteKit

class Invader: SKSpriteNode {
    // Row and column position in the invader grid
    var invaderRow = 0
    var invaderColumn = 0

    init() {
        // Randomly select one of three invader sprite types
        let randNum = Int.random(in: Constants.Invader.imageTypeRange)
        let texture = SKTexture(imageNamed: "invader\(randNum)")
        super.init(texture: texture, color: SKColor.clear, size: texture.size())
        self.name = "invader"

        // Configure physics body for collision detection
        self.physicsBody = SKPhysicsBody(texture: texture, size: self.size)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.usesPreciseCollisionDetection = false
        self.physicsBody?.categoryBitMask = CollisionCategories.invader
        self.physicsBody?.contactTestBitMask = CollisionCategories.playerBullet | CollisionCategories.player
        self.physicsBody?.collisionBitMask = 0x0
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func fireBullet(scene: SKScene) {
        let bullet = InvaderBullet(imageName: "laser", bulletSound: nil)
        bullet.position.x = self.position.x
        bullet.position.y = self.position.y - self.size.height / 2
        scene.addChild(bullet)
        let moveBulletAction = SKAction.move(
            to: CGPoint(x: self.position.x, y: 0 - bullet.size.height),
            duration: Constants.Invader.bulletDuration
        )
        let removeBulletAction = SKAction.removeFromParent()
        bullet.run(SKAction.sequence([moveBulletAction, removeBulletAction]))
    }
}
