const electron = require('electron');
const {app} = electron;
const {BrowserWindow} = electron;
const ipc = require('electron').ipcMain;
const Menu = electron.Menu;
const Tray = electron.Tray;

let win;
let appIcon;
let new_win;

function createWindow(){
	//托盘
	appIcon = new Tray('ming.ico');
	let contextMenu = Menu.buildFromTemplate([
		{label:'Item1',type:'radio'},
		{label:'Item2',type:'radio'},
		{label:'Item3',type:'radio',checked:true},
		{label:'Item4',type:'radio'}
	]);
	appIcon.setToolTip('This is my application.');
	appIcon.setContextMenu(contextMenu);
	//创建窗口
	win = new BrowserWindow({width:800,height:600,frame:false});
	win.loadURL(`file://${__dirname}/index.html`);
	win.webContents.openDevTools();
	win.on('closed',()=>{
		win = null;
	});
}

app.on('ready',createWindow);
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

ipc.on('new-window',()=>{
	if(!new_win){
		new_win = new BrowserWindow({width:400,height:300,frame:false});
		new_win.loadURL(`file://${__dirname}/index.html`);
		new_win.setPosition(0,0);
	}
});

ipc.on('new-window-close',()=>{
	if(new_win){
		new_win.close();
		new_win = null;
	}
});