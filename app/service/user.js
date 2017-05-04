/**
 * Created by guoxiaotian on 2017/5/4.
 */

// // app/service/user.js
// module.exports = app => {
//     class User extends app.Service {
//         // 默认不需要提供构造函数。
//         // constructor(ctx) {
//         //   super(ctx); 如果需要在构造函数做一些处理，一定要有这句话，才能保证后面 `this.ctx`的使用。
//         //   // 就可以直接通过 this.ctx 获取 ctx 了
//         //   // 还可以直接通过 this.app 获取 app 了
//         // }
//         * find(uid) {
//             // 假如 我们拿到用户 id 从数据库获取用户详细信息
//             const user = this.ctx.db.query(`select * from user where uid = ${uid}`);
//             // 假定这里还有一些复杂的计算，然后返回需要的信息。
//             const picture = yield this.getPicture(uid);
//             return {
//                 name: user.user_name,
//                 age: user.age,
//                 picture,
//             };
//         }
//         * getPicture(uid) {
//             const result = yield this.ctx.curl(`http://photoserver/uid=${uid}`, {
//                 dataType: 'json',
//             });
//             return result.data;
//         }
//     }
//     return User;
// };

module.exports = app => {
    class User extends app.Service{
        * find(username,pass){
            const result = yield this.ctx.curl(`https://www.easy-mock.com/mock/5905c8817a878d73716e2bdb/example/user/login`,{dataType:'json'});
            console.log(typeof result.data);
            if (result.data.success){
                let userInfo = result.data.data[0];
            }
            return result.data;
        }
    }

    return User;
};