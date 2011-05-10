package leafy {

public class PMap implements IMap {
    
    public static const EMPTY:IMap = new PMap();
    
    private var tree:IntTree = new IntTree();
    
    public function plus(key:*, val:*):IMap {
        var hash:int = getHash(key);
        
        var entries:IVect = tree.find(hash) as IVect;
        
        if(!entries) {
            // first entry with hash
            entries = PVect.empty().plus(Node.from(key, val));
            return from(tree.plus(hash, entries));
        }
        
        var keyIndex:int = findKeyIndex(key, entries);
        if(keyIndex > -1) {
            entries = entries.minus(keyIndex);
        }
        
        return from(tree.minus(hash).plus(hash, entries));
    }
    
    private function findKeyIndex(key:*, entries:IVect):int {
        var i:int = 0;
        
        while(i < entries.count) {
            var node:Node = entries.at(i);
            if(node.key == key) {
                return i;
            }
        }
        return -1;
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
        var hash:int = getHash(key);
        
        var entries:IVect = tree.find(hash) as IVect;
        if(!entries) {
            return this;
        }
        
        var keyIndex:int = findKeyIndex(key, entries);
        if(keyIndex == -1) {
            return this;
        }
        
        entries = entries.minus(keyIndex);
        
        if(entries.count > 0) {
            return from(tree.minus(hash).plus(hash, entries));
        }
        
        return from(tree.minus(hash));
    }
    
    public function at(key:*):* {
        var entries:IVect = tree.find(getHash(key)) as IVect;
        
        if(!entries) {
            return null;
        }
        
        var node:Node;
        if(entries.count == 1) {
            node = entries.at(findKeyIndex(key, entries));
            return node.val;
        }
        
        return null;
    }
    
    public function get count():int {
        return tree.count;
    }
    
    public static function empty():IMap {
        return EMPTY;
    }
    
    public function get first():* {
        var entries:IVect = tree.first.value as IVect;

        if(!entries) {
            return null;
        }
        
        var node:Node;
        if(entries.count > 0) {
            node = entries.first;
            return node.val;
        }
        
        return null;
    }
    
    public function get rest():ISeq {;
        var entries:IVect = tree.first.value as IVect;
        
        var node:Node = entries.first;
        return from(tree.minus(getHash(node.key)));
    }
    
    public function unite(...args):ISeq {
        return fromArray(args, this);
    }
    
    public static function fromArray(source:Array, root:IMap = null):IMap {
	    var map:IMap = root ? root : EMPTY;
        
        var key:Object;
        var len:int = source.length;
        
        for (var i:int = 0; i < len; i++) {
            if(i % 2 == 0) {
                key = source[i];
            }
            else {
                map = map.plus(key, source[i]);
            }
        }
        
	    return map;
	}
    
    private function from(tree:IntTree):PMap {
        var map:PMap = new PMap();
        map.tree = tree;
        return map;
    }
    
    private static function toHashCode(keyStr:String):int {
        var hash:uint = keyStr.length;
        
        for (var i:int=0; i < keyStr.length; i++) {
        	hash = ((hash << 5) ^ (hash >> 27)) ^ uint(keyStr.charCodeAt(i));
        }
        return hash;
    }
    
}

}

class Node {
    public var key:*;
    public var val:*;
    
    public static function from(key:*, val:*):Node {
        var node:Node = new Node();
        node.key = key;
        node.val = val;
        return node;
    }
    
    public function toString():String {
        return "Node key " + key + " val: " + val;
    }
}
