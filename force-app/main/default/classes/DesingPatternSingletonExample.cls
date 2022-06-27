public class DesingPatternSingletonExample {
    private static DesingPatternSingletonExample objInstance = null;
    public integer accCount;

    public DesingPatternSingletonExample(){
        accCount = [select COUNT() from Account];
    }

    public static DesingPatternSingletonExample getInstance(){
        if(objInstance == null){
            objInstance = new DesingPatternSingletonExample();
        }
        return objInstance;
    }
}
