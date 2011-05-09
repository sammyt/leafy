package leafy {

public class PVect implements IVect {
	
	public static const EMPTY:IVect = new PVect();
	
	private var tree:IntTree = new IntTree();
	
	public function plus(val:*):IVect {
	   return from(tree.plus(tree.count, val));
	}
	
	public function minus(index:int):IVect {
	    return from(tree.minus(index).shiftAboveKey(index, -1));
	}
	
	public function at(index:int):* {
	    return tree.find(index);
	}
	
	public function get count():int {
	   return tree.count;
	}
	
	public static function empty():IVect {
	    return EMPTY;
	}
	
	public function get first():* {
	    return at(0);
	}
	
	public function get rest():ISeq {
	    return minus(0);
	}
	
	public function unite(...args):ISeq {
	    if(args.length == 0) {
	        return this;
	    }
	    if(args.length == 1) {
	        return plus(args[0]);    
	    }
	    else {
	        var next:ISeq = this;
	        for each(var arg:* in args) {
	            next = next.unite(arg);
	        }
	        return next;
	    }
	}
	
	public static function fromArray(source:Array):IVect {
	    var vect:IVect = EMPTY;
        for each (var item:* in source) {
            vect = vect.plus(item);
        }
	    return vect;
	}
	
	private function from(tree:IntTree):PVect {
        var vect:PVect = new PVect();
        vect.tree = tree;
        return vect;
	}
}

}

