package views.scripts
{
	import flash.data.SQLConnection;
	import flash.data.SQLStatement;
	import flash.net.Responder;

	public class Diary extends Table
	{
		
		
		public function Diary(conn:SQLConnection)
		{
			super(conn);
			
			var stat:SQLStatement = new SQLStatement();
			stat.sqlConnection = connection;
			stat.text = "CREATE TABLE IF NOT EXISTS DIARY (id INTEGER PRIMARY KEY AUTOINCREMENT, ddate TEXT, dwhat TEXT, iunitkcal DECIMAL(5, 2), dquantity TEXT, dsumm DECIMAL(5, 2), dnote TEXT)";
			stat.execute();
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
	}
}