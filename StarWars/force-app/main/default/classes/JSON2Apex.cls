public class JSON2Apex {

	public Integer count {get;set;} 
	public String next {get;set;} 
	public Object previous {get;set;} 
	public List<Contact> results {get;set;} 

	public JSON2Apex(JSONParser parser) {
		while (parser.nextToken() != System.JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
					if (text == 'count') {
						count = parser.getIntegerValue();
					} else if (text == 'next') {
						next = parser.getText();
					} else if (text == 'previous') {
						previous = parser.readValueAs(Object.class);
					} else if (text == 'results') {
						results = arrayOfResults(parser);
					} else {
						System.debug(LoggingLevel.WARN, 'JSON2Apex consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	public class Results {
		public String name {get;set;} 
		public String height {get;set;} 
		public String hair_color {get;set;} 
		public String skin_color {get;set;} 
		public String eye_color {get;set;} 
		public String gender {get;set;} 
		public String homeworld {get;set;} 
		public String url {get;set;} 

		public Results(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'name') {
							name = parser.getText();
						} else if (text == 'height') {
							height = parser.getText();
						} else if (text == 'hair_color') {
							hair_color = parser.getText();
						} else if (text == 'skin_color') {
							skin_color = parser.getText();
						} else if (text == 'eye_color') {
							eye_color = parser.getText();
						} else if (text == 'gender') {
							gender = parser.getText();
						} else if (text == 'homeworld') {
							homeworld = parser.getText();
						} else if (text == 'url') {
							url = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Results consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	
	public static JSON2Apex parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new JSON2Apex(parser);
	}
	
	public static void consumeObject(System.JSONParser parser) {
		Integer depth = 0;
		do {
			System.JSONToken curr = parser.getCurrentToken();
			if (curr == System.JSONToken.START_OBJECT || 
				curr == System.JSONToken.START_ARRAY) {
				depth++;
			} else if (curr == System.JSONToken.END_OBJECT ||
				curr == System.JSONToken.END_ARRAY) {
				depth--;
			}
		} while (depth > 0 && parser.nextToken() != null);
	}
	



    private static List<Results> arrayOfResults(System.JSONParser p) {
        List<Results> res = new List<Results>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Results(p));
        }
        return res;
    }




}