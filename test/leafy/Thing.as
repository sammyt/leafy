package leafy
{

public class Thing implements IHash
{
	private static var count:int = 0;
	
	public function Thing() {
	    count++;
	}
	
	public function get hash():int {
	    return count;
	}
}

}

