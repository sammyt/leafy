package leafy
{

public interface ILinkedList extends ISeq {
	
	function plus(val:*):ILinkedList;
	
	function pop():ILinkedList;
}

}

