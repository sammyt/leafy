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
        
        // clear current entry
        tree = tree.minus(hash);
        
        return from(tree.plus(hash, entries));
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
        return null;
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
}
