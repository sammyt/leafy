package leafy  {
    
    import asunit.asserts.*;
    import asunit.framework.IAsync;
    
    import flash.display.Sprite;
    
    import org.hamcrest.assertThat;
    import org.hamcrest.core.*;
    import org.hamcrest.object.*;
    

    public class IntTreeTest {

        [Inject]
        public var async:IAsync;

        [Inject]
        public var context:Sprite;

        private var instance:IntTree;

        [Before]
        public function setUp():void {
            instance = new IntTree();
        }

        [After]
        public function tearDown():void {
            instance = null;
        }

        [Test]
        public function shouldBeInstantiated():void {
            assertTrue("instance is IntTree", instance is IntTree);
        }
        
        [Test]
        public function hasEmpty():void {
            assertNotNull("instance is non null", IntTree.EMPTY);
            assertTrue("instance is IntTree", IntTree.EMPTY is IntTree);
        }
        
        [Test]
        public function addSomething():void {
            var tree:IntTree = instance.plus(1, "wibble");
            assertNotNull(tree);
        }
        
        [Test]
        public function findSomething():void {
            var tree:IntTree = instance.plus(1, "woo");
            assertNotNull(tree);
            assertThat(tree.find(1), equalTo("woo"));
        }
        
        [Test]
        public function addAndFindMore():void {
            var tree:IntTree = instance.plus(1, "one");
            tree = tree.plus(2, "two");
            tree = tree.plus(3, "three");
            tree = tree.plus(4, "four");
            
            assertNotNull(tree);
            assertThat(tree.find(1), equalTo("one"));
            assertThat(tree.find(2), equalTo("two"));
            assertThat(tree.find(3), equalTo("three"));
            assertThat(tree.find(4), equalTo("four"));
        }
        
        [Test]
        public function addAndFindMoreRandomAdd():void {
            var tree:IntTree = instance.plus(1, "one");
            tree = tree.plus(4, "four");
            tree = tree.plus(3, "three");
            tree = tree.plus(2, "two");
            assertNotNull(tree);
            assertThat(tree.find(2), equalTo("two"));
            assertThat(tree.find(3), equalTo("three"));
            assertThat(tree.find(1), equalTo("one"));
            assertThat(tree.find(4), equalTo("four"));
        }
        
        [Test]
        public function removeAnElement():void {
            var tree:IntTree = instance.plus(1, "one");
            tree = tree.plus(4, "four");
            tree = tree.plus(3, "three");
            tree = tree.plus(2, "two");  
            
            assertNotNull(tree);
            assertThat(tree.find(2), equalTo("two"));
            
            assertThat(tree.count, equalTo(4));
            tree = tree.minus(2);
            assertThat(tree.count, equalTo(3));
            
            tree = tree.minus(3);
            assertThat(tree.count, equalTo(2));
            
            assertThat(tree.find(1), equalTo("one"));
            assertThat(tree.find(4), equalTo("four"));
        }
    }
}

