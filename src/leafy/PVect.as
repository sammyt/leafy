package leafy {

public class PVect implements IVect {
	
	public static const EMPTY:PVect = new PVect();
	
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
	
	private function from(tree:IntTree):PVect {
        var vect:PVect = new PVect();
        vect.tree = tree;
        return vect;
	}
}

}

