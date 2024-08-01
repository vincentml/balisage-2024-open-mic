package example;

import org.basex.query.QueryModule;
import org.basex.server.Log.LogType;

public class MyJava extends QueryModule {

    public static String greet1 () {
        return "Hello Balisage from Java (static)";
    }

    public String greet2 () {
        queryContext.context.log.write(LogType.INFO, "saying hello", null, queryContext.context);
        return "Hello Balisage from Java (instance)";
    }

}
