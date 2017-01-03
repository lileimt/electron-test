# electron-test

1.在项目文件夹下创建package.json文件，实现打包脚本

{
 "scripts": {
   "package": "electron-packager ./app app -all --out ./OutApp --version 1.4.13 --overwrite --icon=./app/ming.ico"
	}
}

./app 指定项目文件夹
app 最终的项目名称，exe的名称
./OutApp 项目打包后的目录
version electron-prebuilt的version
icon 指定exe的icon

执行npm run-script package生成打包后的项目文件到OutApp目录中

2.为了避免源代码直接暴露给用户，用asar把resources下面的app文件打包成一个asar的文件
asar pack app app.asar