const electron = require('electron');
const {app} = electron;
const {BrowserWindow} = electron;
const ipc = require('electron').ipcMain;
const Menu = electron.Menu;
const Tray = electron.Tray;

let win = null;
let appIcon = null;
let new_win = null;
let timer = null;

function createWindow(){
	//创建窗口
	win = new BrowserWindow({width:800,height:600,frame:false});
	win.loadURL(`file://${__dirname}/index.html`);
	win.webContents.openDevTools();
	win.on('closed',()=>{
		win = null;
	});
}

app.on('ready',()=>{
	createWindow();
	//托盘
	appIcon = new Tray('ming.ico');
	let contextMenu = Menu.buildFromTemplate([
		{label:'Item1',type:'normal',click:function(){console.log(sss);}},
		{label:'Item2',type:'separator'},
		{label:'close',type:'normal',click:function(){app.quit();}}
	]);
	appIcon.setToolTip('随想随享');
	appIcon.setContextMenu(contextMenu);
	appIcon.on('double-click',()=>{
		win.isVisible() ? win.hide() : win.show();
	});
	//appIcon.on('balloon-show',()=>{
	//	if(timer){
	//		console.log('ssssssssssssssssssssss');
	//	}
	//	console.log('ddddddddddd');
	//})
});

app.on('window-all-closed',()=>{
	//if(process.platform !== 'darwin'){
		app.quit();
	//}
});
app.on('activate',()=>{
	if(mainWindow === null){
		createWindow();
	}
});

//通过ipc控制窗口状态
ipc.on('close-main-window',()=>{
	app.quit();
});

ipc.on('change-main-size',(event,arg)=>{
	win.hide();
	//console.log(JSON.stringify(arg));
	win.setSize(arg.width,arg.height);
	win.center();
	win.loadURL(`file://${__dirname}/index.html`);
	win.show();
});

ipc.on('expand-window',()=>{
	if(win.isMaximized()){
		win.restore();
	}else{
		win.maximize();
	}
});

ipc.on('new-window',()=>{
	if(!new_win){
		new_win = new BrowserWindow({width:300,height:200,frame:false});
		new_win.loadURL(`file://${__dirname}/index.html`);
		const {width, height} = electron.screen.getPrimaryDisplay().workAreaSize;
		//console.log(width+":"+height);
		new_win.setPosition(width-300,height-200);
	}
});

ipc.on('new-window-close',()=>{
	if(new_win){
		new_win.close();
		new_win = null;
	}
});

ipc.on('tray-shrink',()=>{
	var bounds = appIcon.getBounds();
	console.log(JSON.stringify(bounds));
	if(timer){
		clearInterval(timer);
	}
	var i = 0;
	timer = setInterval(()=>{
		if(i % 2 == 0){
			appIcon.setImage('ming.ico');
		}else{
			appIcon.setImage('nodata.png');
		}
		i++;
	},500);
});

ipc.on('tray-shrink-close',()=>{
	if(timer){
		clearInterval(timer);
		timer = null;
		appIcon.setImage('ming.ico');
	}
});

