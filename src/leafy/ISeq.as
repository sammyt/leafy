package leafy {

public interface ISeq {
    
	function first():ISeq;
	
	function rest():ISeq;
	
	function unite(...args):ISeq;
}

}

