package leafy {

public class PVect implements IVect {
	
	public static const EMPTY:IVect = new PVect();
	
	private var tree:IntTree = new IntTree();
	
	public function plus(val:*):IVect {
	   return from(tree.plus(tree.count + 1, val));
	}
	
	public function minus(index:int):IVect {
	   return from(tree.minus(index));
	}
	
	public function at(index:int):* {
	    return tree.find(index);
	}
	
	public function get count():int {
	   return tree.count;
	}
	
	public function get empty():IVect {
	    return EMPTY;
	}
	
	public function first():ISeq {
	    return null;
	}
	
	public function rest():ISeq {
	    return null;
	}
	
	public function unite(...args):ISeq {
	    return null;
	}
	
	private function from(tree:IntTree):PVect {
        var vect:PVect = new PVect();
        vect.tree = tree;
        return vect;
	}
}

}

