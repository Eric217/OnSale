齐鲁软件大赛作品
```swift

接口文档预览
********************************************************
全局：
{
	status: 200    //一个三位整数
	message: "OK"  //一个简短的英文短语用于说明
	data: {}       //请求的数据
}

***********返回信息格式的具体说明***********************
{
	status:200,message:"OK"     				//代表成功
	status:300,message:"failure"  				//代表失败
}

*******************上传新商品**************************

URL:/api/normal/goods/upload
method:POST（multipartFormData）
    type:1, //商品种类 int ，非负数
    title:"title",//描述题目 String
    description:"description"//描述内容 String
    l1:一级，省
    l2:二级，市
    l3:三级，区
    longitude:double  //经度
    latitude:double   //纬度
    deadline:"2018-08-09 09:09:09",// 最后有效期 String
    pic: [“http://12345677” , ”http://2132445456] //这是图片的 url 的 String 数组.以后可能扩展成 视频 url

}

response{
	"status":200
	"message":"OK"
}

***********************获取商品***********************
URL:/api/anonymous/goods/getGoods
method；POST
request:{
	id : 100  //如果没写，就是任意id
	type ：2  // 如果没写 就是任意type数据
	page ：2  // 请求第几页，没写就是第一页
	rows ：10 // 请求几条，没写就是第一条，最多一整页10条
	userID ：int // 上传者。id
	l1: 一级
	l2: 二级
	l3: 三级
	title: String
	isValid: int //没写就是任意。1代表有效，0代表已过期
}
response:
{
	"status":200
	"message":"OK"
	"data":
	{
		total: 100
		data: [
			{
			    id:132
			    type:1, //商品种类 int 
			    title:"title",//描述题目 String
			    description:"description"//描述内容 String
			    l1: 一级
			    l2: 二
			    l3: 三级
			    longitude:double  //经度
  			    latitude:double   //纬度
			    date:"2016-01-02 12:40:00", //上传时间 String
			    deadline:"2018-08-09 09:09:09",//  截止String
			    isValid:int
			    user:{
				userID: 上传者ID
				nickName: 上传者昵称
			   	mark:int
				...
			    }
			 
			    pic: [“http://12 7” , ”http://2156] //图片url的String 数组.以后扩展成视频 url
			    
		    }
		    ...
		]
	}
}
*******************删除我发布的商品**************************

URL:/api/normal/goods/deleteGood
method:POST
{
	goodsID:[int]    //商品id数组
	
}
response{
	"status":200
	"message":"OK"
}
************************发表评论**********************
URL:/api/normal/comment/addComment
method:POST
request:
{
	goodID:int     //商品id
	content:"abc"  //评论内容（现在是String，等以后可以做成像发布商品那样，multipartFormData，有图有字）
}
response:
{
	"status":200
	"message":"OK"
}

************************获取评论**********************
URL:/api/anonymous/comment/getComment
method；GET
request:{
	id:100  //评论的ID，如果没写就是任意id
   	goodsID ：2  // 如果没写 就是任意
	userID ：int  // 评论者ID 没写就是任意
	page ：2  // 请求第几页，没写就是第一页
  	rows ：10 // 请求几条，没写就是第一条，最多一整页10条
}
response:
{
	"status":200
	"message":"OK"
	"data":
	{
		total: 总条数（不是页数），用于分页（满足一个条件的总数）
		data:[
			{
			    id:int 
			    goodID:int //商品id
			    user{
			        userID:int //评论者ID
			        nickName: 评论者昵称
			    ...
			    }
		
			    
			    content:"abc"//描述内容 String
    			    date:"2016-01-02 12:40:00", //上传时间 String
			 }
		    ...
		]
	}
}
*******************删除评论**************************

URL:/api/normal/comment/deleteComment
method:POST
{
	commentID:[int]    //id数组
	
}
response{
	"status":200
	"message":"OK"
}
************************注册用户**********************
URL:/api/anonymous/signUp
method:POST
request:
{
	email:"123@123" // 邮箱 String
	phone:"1234567" // 手机 String	//手机或邮箱在post的时候只有一个会赋值
	nickName:”abc"  // 昵称 String 
	password:"abc"  // 密码 String
	gender:"abc" // 性别
}

response:
{
	"status":200
	"message":"OK"
}
*********************验证是否已经注册*********************
验证账号或手机号或邮箱是否已经注册过用户
URL:/api/anonymous/validateSignUp
method:POST
request:
{
	email:"123@123" // 邮箱 String
	phone:"1234567" // 手机 String
	//手机或邮箱在post的时候只有一个会有值
	nickName:”abc"  // 昵称 String 
	
	//加上 昵称，一共传2个参数。任意一个传入参数都要求在数据库中唯一，否则 状态码  fail。
	
}
response:
{
	"status":200
	"message":"OK"
}

***************************登录**************************
URL:/api/anonymous/user/signIn
method:POST
request:
{
	email:"123@123" // 邮箱 String
	phone:"1234567" // 手机 String
	nickName:”abc"  // 昵称 String
	//这三个只有一个会有值
	password:"abc"  // 密码  	String	
}
response:
{
	status:200
	message:"OK"
	data:{
		id:int
		mark:int
		type:int 
		gender:String //性别
		nickName:String
		password:String
		phone:String
		email:String
		realName:String //真名
		realID:String   //身份证
	}
}
***********************获取用户信息*********************
URL:/api/anonymous/user/getUserInfo
method:GET
request:
{
	id:int
	nickName:”abc"  // 昵称 String
	email:"123@123" // 邮箱 String
	phone:"1234567" // 手机 String
	//这4值个只有一个会赋值
}
response:
{
	status:200
	message:"OK"
	data:{
		id:int
		mark:int
		type:int 
		gender:String //性别
		nickName:String
		phone:String
		email:String
		realName:String //真名
		realID:String   //身份证
		pic:String //头像图片的 url
		...
	}
}

********************修改信息***************************
URL:/api/normal/user/changeInfo
method:POST
request:
{
	id:123 // 要修改的人 的id
	//下面参数只会有一个有值
	type: int 
	gender: String
	nickName: String
	password: String
	phone: String
	email: String
	realName: String
	realID: String
	
}
response:
{
	"status":200
	"message":"OK"
}
***********************修改头像**************************
URL:/api/normal/user/changePic
method:POST
request:
{
	img: MultipartData   // 图片文件	
}
response:
{
	"status":200
	"message":"OK"
}
**********************访问收藏夹**************************
URL:/api/normal/favorite/getFavorite
method:GET
request {
	page:
	rows:
}

response:
{
	"status":200
	"message":"OK"
	"data":
	{
		total: 100
		data: [
			{
			    id:132
			    type:1, //商品种类 int 
			    title:"title",//描述题目 String
			    description:"description"//描述内容 String
			    l1: 一级
			    l2: 二级
			    l3: 三级
			    longitude:double  //经度
  			    latitude:double   //纬度
			    date:"2016-01-02 12:40:00", //上传时间 String
			    deadline:"2018-08-09 09:09:09",//  截止String
			    isValid:int
			    userID: 上传者ID
			    nickName: 上传者昵称
			    pic: [“http://12 7” , ”http://2156] //图片url的String 数组.以后扩展成视频 url
		    }
		    ...
		]
	}
}

**********************添加到收藏夹**************************
URL:/api/normal/favorite/addFavorite
method:POST
request {
	goodsID:int
}
response {
	status:200
	message:OK
}
*******************删除收藏**************************

URL:/api/normal/favorite/deleteFavor
method:POST
{
	goodsID:[int]    //id数组
	
}
response{
	"status":200
	"message":"OK"
}
*******************请求验证码1**************************

URL:/api/anonymous/verify/phone
method:POST
{
	phone:String	
}
response{
	"status":200
	"message":"OK"
}
*******************请求验证码2**************************

URL:/api/anonymous/verify/code
method:POST
{
	code:int
}
response{
	"status":200
	"message":"OK"
	"data":{
	
	//和正常登陆返回的内容一样
	
	
	}
	
}



***************************附录****************************
用户的全部属性：
id:int
mark:int//第一次100分，普通10分，评论1分
gender:String //性别
userID:String
password:String
phone:String
email:String
realName:String //真名
realID:String   //身份证
pic:image

//访问图片的地址：
img/{id}/portrait.png

type:int 
1 : normal(default)
2 : seller //卖东西的
3 : unknown(扩展用。未登录用户我来处理，不计入type)
```
