
@IsTest
public with sharing class JSON2Apex_Test {
	
	// This test method should give 100% coverage
	static testMethod void testParse() {
		String json = '{'+
		'	\"count\": 82,'+
		'	\"next\": \"https://swapi.dev/api/people/?page=2\",'+
		'	\"previous\": null,'+
		'	\"results\": ['+
		'		{'+
		'			\"name\": \"Luke Skywalker\",'+
		'			\"height\": \"172\",'+
		'			\"hair_color\": \"blond\",'+
		'			\"skin_color\": \"fair\",'+
		'			\"eye_color\": \"blue\",'+
		'			\"gender\": \"male\",'+
		'			\"homeworld\": \"https://swapi.dev/api/planets/1/\",'+
		'			\"url\": \"https://swapi.dev/api/people/1/\"'+
		'		}'+
		'	]'+
		'}';
		JSON2Apex r = JSON2Apex.parse(json);
		System.assert(r != null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		JSON2Apex objJSON2Apex = new JSON2Apex(System.JSON.createParser(json));
		System.assert(objJSON2Apex != null);
		System.assert(objJSON2Apex.count == null);
		System.assert(objJSON2Apex.next == null);
		System.assert(objJSON2Apex.previous == null);
		System.assert(objJSON2Apex.results == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		JSON2Apex.Results objResults = new JSON2Apex.Results(System.JSON.createParser(json));
		System.assert(objResults != null);
		System.assert(objResults.name == null);
		System.assert(objResults.height == null);
		System.assert(objResults.hair_color == null);
		System.assert(objResults.skin_color == null);
		System.assert(objResults.eye_color == null);
		System.assert(objResults.gender == null);
		System.assert(objResults.homeworld == null);
		System.assert(objResults.url == null);
	}
}