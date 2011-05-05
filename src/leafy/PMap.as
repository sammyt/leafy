package leafy {

public class PMap implements IMap {
    
    public static const EMPTY:IMap = new PMap();
    
    private var tree:IntTree = new IntTree();
    
    public function plus(key:*, val:*):IMap {
        
        var hash:int;
        
        if(key is IHash) {
            hash = IHash(key).hash;
            
        }
        
        return null;
    }
	
	public function minus(key:*):IMap {
	    return null;
	}
	
	public function at(key:*):* {
	    return null;
	}
	
	public function get count():int {
	    return -1;
	}
	
	public function get empty():IMap {
	    return EMPTY;
	}
	
	public function addHashForType(type:Class, fn:Function):IMap {
	    return this;
	}
	
	private function from(tree:IntTree):PMap {
        var map:PMap = new PMap();
        map.tree = tree;
        return map;
	}
    
}

}

