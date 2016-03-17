package views.scripts
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class Status extends EventDispatcher
	{
		[Bindable]
		public var  operation:String;
		
		public function Status(target:IEventDispatcher=null)
		{
			super(target);
		}
	}
}