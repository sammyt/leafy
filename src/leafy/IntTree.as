package leafy 
{

public final class IntTree {

    public static const EMPTY:IntTree = new IntTree();

    public var key:Number;
    public var value:Object;
    public var left:IntTree;
    public var right:IntTree;
    public var count:uint = 0;
    
    public function IntTree(key:Number = 0, value:Object= null, 
            left:IntTree = null, right:IntTree = null) {
        this.key = key;
        this.left = left;
        this.right = right;
        this.value = value;
        
        if(left && right) {
            count = 1 + left.count + right.count;
        }
    }
    
    public function find(key:Number):Object {
        if(count == 0) {
            return null;
        }
        else if(key > this.key) {
            return right.find(key);
        }
        else if(key < this.key) {
            return left.find(key);
        }
        return value
    }
    
    public function plus(key:Number, value:Object):IntTree {
        if(count == 0) {
            trace("added", value);
            return new IntTree(key - this.key, value, this, this);
        }
        
        var newKey:Number = key - this.key;
        if(key < this.key) {
			return balanced(left.plus(key - this.key, value), right);
		} 
		else if(key > this.key) {
			return balanced(left, right.plus(key - this.key, value));
		}
		if(value == this.value) {
		    return this;
		}
        return new IntTree(key - this.key, value, left, right);
    }

    public function balanced(left:IntTree, right:IntTree):IntTree {
        if(left == this.left && right == this.right) {
            return this;
        }
        return rebalanced(key, value, left, right);
    }
    
    public function toString():String {
        return "<IntTree Key: " + key + ", value: " 
            +  value + ", count:" + count +", left: " + left + ", right:" + right;
    }
    
    public static const OMEGA:int = 5;
    public static const ALPHA:int = 2;
    
    public static function rebalanced(key:Number, value:Object, left:IntTree, right:IntTree):IntTree {
        if(left.count || right.count) {
            if(left.count >= OMEGA * right.count) {
                var once:IntTree = rotateRight(key, value, left, right);
                if(left.right.count < ALPHA * left.left.count) {
                    return once;
                }
                else {
                    return rotateRight(once.key, once.value, once.left, once.right);
                }
            }
            else if(right.count >= OMEGA * left.count) {
                
            }
        }
        return null;
    }
    
    public static function rotateRight(key:Number, value:Object, left:IntTree, right:IntTree):IntTree {
        return null;
    }
    
    public static function rotateLeft(key:Number, value:Object, left:IntTree, right:IntTree):IntTree {
        return null;
    }
    
}
}

