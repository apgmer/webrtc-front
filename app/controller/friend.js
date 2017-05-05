/**
 * Created by guoxiaotian on 2017/5/5.
 */

module.exports = app => {
    class FriendController extends app.Controller{
        constructor(ctx){
            super(ctx)
        }
    }

    return FriendController;
};