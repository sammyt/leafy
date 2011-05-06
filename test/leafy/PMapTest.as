package leafy  {
    
    import asunit.asserts.*;
    import asunit.framework.IAsync;
    
    import flash.display.Sprite;
    
    import org.hamcrest.assertThat;
    import org.hamcrest.core.*;
    import org.hamcrest.object.*;

    public class PMapTest {

        [Inject]
        public var async:IAsync;

        [Inject]
        public var context:Sprite;

        private var instance:PMap;

        [Before]
        public function setUp():void {
            instance = new PMap();
        }

        [After]
        public function tearDown():void {
            instance = null;
        }

        [Test]
        public function shouldBeInstantiated():void {
            assertTrue("instance is PMap", instance is PMap);
        }
        
        [Test]
        public function addHasImpl():void {
            var thing:Thing = new Thing();
            var map:IMap = instance.plus(thing, "a value");
            
            assertThat(map.count, equalTo(1));
            assertThat(instance.count, equalTo(0));
            
            assertThat(map.at(thing), equalTo("a value"));
        }
    }
}

