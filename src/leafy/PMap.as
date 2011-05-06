package leafy {

public class PMap implements IMap {
    
    public static const EMPTY:IMap = new PMap();
    
    private var tree:IntTree = new IntTree();
    
    public function plus(key:*, val:*):IMap {
        
        var hash:int;
        
        if(key is IHash) {
            hash = IHash(key).hash;
            return from(tree.plus(hash, val))
        }
        
        throw new Error("eek");
        
        return null;
    }
	
	public function minus(key:*):IMap {
	    return null;
	}
	
	public function at(key:*):* {
	    var hash:int;
        
        if(key is IHash) {
            hash = IHash(key).hash;
            return tree.find(hash);
        }
        
        throw new Error("eek");
        
	    return null;
	}
	
	public function get count():int {
	    return tree.count;
	}
	
	public function get empty():IMap {
	    return EMPTY;
	}
	
	public function addHashForType(type:Class, fn:Function):IMap {
	    return this;
	}
	
	public function get first():* {
	    return null;
	}
	
	public function get rest():ISeq {
	    return null;
	}
	
	public function unite(...args):ISeq {
	    return null;
	}
	
	private function from(tree:IntTree):PMap {
        var map:PMap = new PMap();
        map.tree = tree;
        return map;
	}
    
}

}


