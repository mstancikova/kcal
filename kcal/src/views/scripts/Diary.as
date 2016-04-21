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
		public var ingredient:String;
		
		private var _unitkcal:String;
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
			stat.text = "CREATE TABLE IF NOT EXISTS DIARY (id INTEGER PRIMARY KEY AUTOINCREMENT, ddate TEXT, ingredient TEXT, unitkcal DECIMAL(5, 2), dquantity DECIMAL(5, 2), dsumm DECIMAL(5, 2), dnote TEXT)";
			stat.execute();
		}
		
		[Bindable]
		public function get unitkcal():String
		{
			return _unitkcal;
		}

		public function set unitkcal(value:String):void
		{
			_unitkcal = value;
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
			dsumm = String(Number(_dquantity)*Number(_unitkcal));	
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
			ingredient = "";
			unitkcal = "0";
			dquantity = "0";
			dsumm = "0";
			dnote = "";
			status.operation = "New";
		}
		
		public function editItem(item:Object):void
		{
			id = item.id;
			ddate = new Date(item.ddate);
			ingredient = item.dwhat;
			unitkcal = item.unitkcal;
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
			stat.parameters["@ingredient"] = ingredient;
			stat.parameters["@unitkcal"] = unitkcal;
			stat.parameters["@dquantity"] = dquantity;
			stat.parameters["@dsumm"] = dsumm;
			stat.parameters["@dnote"] = dnote;
			if(id == -1){
				stat.text = "INSERT INTO DIARY (ddate, ingredient, unitkcal, dquantity, dsumm, dnote) VALUES (@ddate, @ingredient, @unitkcal, @dquantity, @dsumm, @dnote)";
			}else{
				stat.parameters["@id_diary"] = id;
				stat.text = "UPDATE DIARY SET ddate=@ddate, ingredient=@ingredient, unitkcal=@unitkcal, dquantity=@dquantity, dsumm=@dsumm, dnote=@dnote WHERE id=@id_diary";
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