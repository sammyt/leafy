package leafy {

public interface IMap extends ISeq {
	
	function plus(key:*, val:*):IMap;
	
	function minus(key:*):IMap;
	
	function at(key:*):*;
}

}

