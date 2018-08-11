import Crypto
import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // public routes
    let tokenController = TokenController()
    try router.register(collection: tokenController)

//     // basic / password auth protected routes
//     let basic = router.grouped(User.basicAuthMiddleware(using: BCryptDigest()))
//     basic.post("login", use: userController.login)

//     // bearer / token auth protected routes
//     let bearer = router.grouped(User.tokenAuthMiddleware())
// //    let todoController = TodoController()
// //    bearer.get("todos", use: todoController.index)
// //    bearer.post("todos", use: todoController.create)
// //    bearer.delete("todos", Todo.parameter, use: todoController.delete)
}
