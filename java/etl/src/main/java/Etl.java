import java.util.HashMap;
import java.util.List;
import java.util.Map;

public final class Etl
{

    public Map<String, Integer> transform(Map<Integer, List<String>> old)
    {
        final Map<String, Integer> map = new HashMap<String, Integer>();
        if (old == null)
        {
            return map;
        }

        for (Map.Entry<Integer, List<String>> e : old.entrySet())
        {
            final Integer count = e.getKey();
            final List<String> letters = e.getValue();
            for (String letter : letters)
            {
                map.put(letter.toLowerCase(), count);
            }
        }
        return map;
    }

}
