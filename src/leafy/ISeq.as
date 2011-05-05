package leafy {

public interface ISeq {
    
	function get first():*;
	
	function get rest():ISeq;
	
	function unite(...args):ISeq;
}

}

