package views.scripts
{
	import flash.data.SQLConnection;
	import flash.data.SQLStatement;
	import flash.net.Responder;
	
	import views.scripts.Functions;

	public class Diary extends Table
	{
		
		//current record data
		[Bindable]
		public var id:int;
		[Bindable]
		public var ddate:Date;
		[Bindable]
		public var dwhat:String;
		
		private var _iunitkcal:String;
		private var _dquantity:String;
		
		[Bindable]
		public var dsumm:String;
		[Bindable]
		public var dnote:String;
		
		//curent record non db data
		[Bindable]
		public var unitname:String;
		
		
		
		public function Diary(conn:SQLConnection)
		{
			super(conn);
			
			var stat:SQLStatement = new SQLStatement();
			stat.sqlConnection = connection;
			stat.text = "CREATE TABLE IF NOT EXISTS DIARY (id INTEGER PRIMARY KEY AUTOINCREMENT, ddate TEXT, dwhat TEXT, iunitkcal DECIMAL(5, 2), dquantity DECIMAL(5, 2), dsumm DECIMAL(5, 2), dnote TEXT)";
			stat.execute();
		}
		
		[Bindable]
		public function get iunitkcal():String
		{
			return _iunitkcal;
		}

		public function set iunitkcal(value:String):void
		{
			_iunitkcal = value;
			updateSumm();
		}

		[Bindable]
		public function get dquantity():String
		{
			return _dquantity;
		}

		public function set dquantity(value:String):void
		{
			_dquantity = value;
			updateSumm();
		}
		
		private function updateSumm():void{
			dsumm = String(Number(_dquantity)*Number(_iunitkcal));	
		}

		public function selectItems(rowsResponder:Responder, summResponder:Responder):void{
			var stat:SQLStatement = new SQLStatement();
			stat.sqlConnection = connection;
			stat.text = "SELECT * FROM DIARY WHERE ddate='"+Functions.getDateFormated(new Date())+"' ORDER BY id";
			stat.execute( -1, rowsResponder);
			
			var stat1:SQLStatement = new SQLStatement();
			stat1.sqlConnection = connection;
			stat1.text = "SELECT sum(dsumm) AS somma FROM DIARY WHERE ddate='"+Functions.getDateFormated(new Date())+"'";
			stat1.execute( -1, summResponder);
		}
		
		public function newItem():void
		{
			id = -1;
			ddate = new Date();
			dwhat = "";
			iunitkcal = "0";
			dquantity = "0";
			dsumm = "0";
			dnote = "";
			status.operation = "New";
		}
		
		public function editItem(item:Object):void
		{
			id = item.id;
			ddate = new Date(item.ddate);
			dwhat = item.dwhat;
			iunitkcal = item.iunitkcal;
			dquantity = item.dquantity;
			dsumm = item.dsumm;
			dnote = item.dnote;
			status.operation = "Edit";
		}
		
		public function saveItem():void
		{
			var stat:SQLStatement = new SQLStatement();
			stat.sqlConnection = connection;
			stat.parameters["@ddate"] = Functions.getDateFormated(ddate);
			stat.parameters["@dwhat"] = dwhat;
			stat.parameters["@iunitkcal"] = iunitkcal;
			stat.parameters["@dquantity"] = dquantity;
			stat.parameters["@dsumm"] = dsumm;
			stat.parameters["@dnote"] = dnote;
			if(id == -1){
				stat.text = "INSERT INTO DIARY (ddate, dwhat, iunitkcal, dquantity, dsumm, dnote) VALUES (@ddate, @dwhat, @iunitkcal, @dquantity, @dsumm, @dnote)";
			}else{
				stat.parameters["@id_diary"] = id;
				stat.text = "UPDATE DIARY SET ddate=@ddate, dwhat=@dwhat, iunitkcal=@iunitkcal, dquantity=@dquantity, dsumm=@dsumm, dnote=@dnote WHERE id=@id_diary";
			}
			stat.execute();
		}
		
		public function deleteItem(item:Object):void
		{
			var stat:SQLStatement = new SQLStatement();
			stat.sqlConnection = connection;
			stat.parameters["@id_diary"] = item.id;
			stat.text = "DELETE FROM DIARY WHERE id=@id_diary";
			stat.execute();	
		}

	}
}