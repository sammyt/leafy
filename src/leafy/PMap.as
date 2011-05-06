package leafy {

public class PMap implements IMap {
    
    public static const EMPTY:IMap = new PMap();
    
    private var tree:IntTree = new IntTree();
    
    public function plus(key:*, val:*):IMap {
        var hash:int = getHash(key);
        return from(tree.plus(hash, Node.from(key, hash, val)));
    }
    
    private function getHash(key:*):int {
        if(key is IHash) {
            return IHash(key).hash;
        }
        else if(key is String) {
            return toHashCode(key);
        }
        else if(key is Number) {
            return toHashCode(key.toString());
        }
        
        return -1;
    }
    
    public function minus(key:*):IMap {
        return from(tree.minus(getHash(key)));
    }
    
    public function at(key:*):* {
        return tree.find(getHash(key)).val;
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
    
    private static function toHashCode(keyStr:String):int {
        var hash:uint = keyStr.length;
        
        for (var i:int=0; i < keyStr.length; i++) {
        	hash=((hash << 5) ^ (hash >> 27)) ^ uint(keyStr.charCodeAt(i));
        }
        return hash;
    }
    
}

}

class Node {
    public var hash:int;
    public var key:*;
    public var val:*;
    
    public static function from(key:*, hash:int, val:*):Node {
        var node:Node = new Node();
        node.key = key;
        node.hash = hash;
        node.val = val;
        return node;
    }
}
