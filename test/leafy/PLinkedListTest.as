package leafy  {
    
    import asunit.asserts.*;
    import asunit.framework.IAsync;
    
    import flash.display.Sprite;
    
    import org.hamcrest.assertThat;
    import org.hamcrest.core.*;
    import org.hamcrest.object.*;
    
    public class PLinkedListTest {

        [Inject]
        public var async:IAsync;

        [Inject]
        public var context:Sprite;

        private var instance:PLinkedList;

        [Before]
        public function setUp():void {
            instance = new PLinkedList();
        }

        [After]
        public function tearDown():void {
            instance = null;
        }

        [Test]
        public function shouldBeInstantiated():void {
            assertTrue("instance is PLinkedListTest", instance is PLinkedList);
        }
        
        [Test]
        public function plus():void {
            var list:ILinkedList = instance.plus("ello");
            
            assertThat(instance.count, equalTo(0));
            assertThat(list.count, equalTo(1));
        }
        
        [Test]
        public function plusMore():void {
            var list:ILinkedList = instance.plus("ello");
            list = list.plus("woo");
            list = list.plus("bar");
            assertThat(instance.count, equalTo(0));
            assertThat(list.count, equalTo(3));
        }
        
        [Test]
        public function addingViaUnite():void {
            var list:ILinkedList = instance.unite("ello", "woo", "bar") as ILinkedList;
            assertThat(instance.count, equalTo(0));
            assertThat(list.count, equalTo(3));
            assertThat(list.first, equalTo("bar"));
            assertThat(list.rest.first, equalTo("woo"));
            assertThat(list.rest.rest.first, equalTo("ello"));
        }
        
        [Test]
        public function first():void {
            var list:ILinkedList = instance.plus("ello");
            list = list.plus("woo");
            list = list.plus("bar");
            assertThat(list.first, equalTo("bar"));
        }
        
        [Test]
        public function rest():void {
            var list:ILinkedList = instance.plus("ello");
            list = list.plus("woo");
            list = list.plus("bar");
            assertThat(list.rest.count, equalTo(2));
            assertThat(list.rest.rest.count, equalTo(1));
        }
    }
}

