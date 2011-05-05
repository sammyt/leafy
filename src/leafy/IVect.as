package leafy {

public interface IVect extends ISeq {
	
	function plus(val:*):IVect;
	
	function minus(index:int):IVect;
	
	function at(index:int):*;
	
	function get count():int;
	
	function get empty():IVect;
}

}

