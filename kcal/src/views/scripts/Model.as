package views.scripts
{
	
	import flash.data.SQLConnection;
	import flash.data.SQLMode;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.filesystem.File;
	import flash.net.Responder;
	
	import views.scripts.Functions;

	public class Model extends Object
	{
		
		private static var _instance:Model;
		
		private var connection:SQLConnection;
		
		private var diary:Diary;
		
		
				
		public function Model()
		{
			if(_instance){
				throw new Error("Singleton... use getInstance()");
			} 
			_instance = this;
			init();
		}
		
		public static function getInstance():Model{
			if(!_instance){
				new Model();
			} 
			return _instance;
		}		
		
		
		
		private function init():void{		
			var dbFile:File = File.applicationDirectory.resolvePath("db/kcal_01.db");
			var dbWorkFile:File = File.documentsDirectory.resolvePath("kcal_01.db");
			//var dbFile:File = File.applicationStorageDirectory.resolvePath("kcal_01.db");
			connection = new SQLConnection();
			connection.open(dbFile, SQLMode.CREATE);
			connection.addEventListener(SQLErrorEvent.ERROR, onError);
			
			
			//open tables
			diary = new Diary(connection);
		}
		protected function onError(event:SQLErrorEvent):void{
			trace(event.text);
		}
		
		
		public function getDiary() : Diary
		{
			return diary;
		}
		
		
		
		
		
		
	}
}