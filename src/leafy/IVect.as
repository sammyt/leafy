package leafy {

public interface IVect {
	
	function plus(val:*):IVect;
	
	function minus(index:int):IVect;
	
	function at(index:int):*;
	
	function get count():int;
}

}

