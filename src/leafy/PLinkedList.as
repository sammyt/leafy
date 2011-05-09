package leafy {

public class PLinkedList implements ILinkedList {

    private static const EMPTY:ILinkedList = new PLinkedList();

    private var _rest:ILinkedList;
    private var _val:*;
    private var _count:int = 0;

    public function plus(val:*):ILinkedList {
        return from(val, this);
    }
    
    public function pop():ILinkedList {
        return _rest;
    }
    
    public function get first():* {
        return _val;
    }
    
	public function get rest():ISeq {
	    return _rest;
	}
	
	public function unite(...args):ISeq {
	    
	    var i:int = 0;
	    var list:ILinkedList = this;
	    
	    while(i < args.length) {
	        list = list.plus(args[i]);
	        i++;
	    }
	    
	    return list;
	}
	
	public function get count():int {
	    return _count;
	}

    private function from(val:*, rest:ILinkedList):ILinkedList {
        var list:PLinkedList = new PLinkedList();
        list._val = val;
        list._rest = rest;
        list._count = count + 1;
        return list;
    }
}
}

