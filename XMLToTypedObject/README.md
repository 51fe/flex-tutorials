XMLToTypedObject
================

Convert XML to AS3 Strong typed object in Web Service


<?xml version="1.0" encoding="utf-8"?>
<s:Application xmlns:fx="http://ns.adobe.com/mxml/2009" 
	xmlns:s="library://ns.adobe.com/flex/spark"
	xmlns:mx="library://ns.adobe.com/flex/mx"
	xmlns:services="services.*"
	xmlns:model="com.riafan.model.*"
	creationComplete="init()">
	
	<fx:Script>
		<![CDATA[
			import com.adobe.serializers.xml.XMLDecoder;
			import com.riafan.model.Person;
			
			import mx.collections.ArrayCollection;
			import mx.controls.Alert;
			import mx.rpc.events.FaultEvent;
			import mx.rpc.events.ResultEvent;
			import mx.rpc.xml.SchemaTypeRegistry;
			
			[Bindable]
			private var resultStr:String;
			
			private var xmlDecoder:XMLDecoder = new XMLDecoder();
			
			private var person:Person = new Person();
			
			protected function init():void
			{	
				/*
				eclipse\plugins\com.adobe.flexbuilder.project_4.7.0.349722\dcradSwcs\4.5\libs\serializers.swc
				eclipse\plugins\com.adobe.flexbuilder.project_4.7.0.349722\dcradSwcs\4.5\locale\zh_CN\serializers_rb.swc
				<?xml version="1.0"?>
				<xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema"
				targetNamespace="http://www.w3school.com.cn"
				xmlns="http://www.w3school.com.cn"
				elementFormDefault="qualified">
				
				<xs:element>
				  <xs:complexType  name="Person">
					<xs:sequence>
					  <xs:element name="age" type="xs:int"/>
					  <xs:element name="name" type="xs:string"/>
					  <xs:element name="married" type="xs:boolean"/>
					</xs:sequence>
				  </xs:complexType>
				</xs:element>
				
				</xs:schema>*/
				var qname:QName = new QName("http://www.riafan.com/", "Person");
				SchemaTypeRegistry.getInstance().registerClass(qname, Person);
				
			}
			
			protected function wsGetVO(event:MouseEvent):void
			{
				ws.getTypedObject();
			}
			
			protected function onWSGetVOResult(event:ResultEvent):void
			{
				currentState = "normal";
				resultStr = introduce(event.result as Person);
			}
			
			protected function introGetVO(event:MouseEvent):void
			{
				introService.getTypedObject();
			}
			
			protected function onIntroGetVOResult(event:ResultEvent):void
			{
				currentState = "normal";
				person = xmlDecoder.decode(event.result[0], Person, "getTypedObjectResponse/getTypedObjectResult");
				resultStr = introduce(person);
			}
			
			protected function wsSendVO(event:MouseEvent):void
			{
				person.name = "Mike";
				person.age = 24;
				person.married = false;
				ws.sendTypedObject(person);
			}
			
			protected function onWSSendVOResult(event:ResultEvent):void
			{
				currentState = "normal";
				resultStr = String(event.result);
			}

			protected function introSendVO(event:MouseEvent):void
			{
				person = new Person();
				person.name = "Kite";
				person.age = 28;
				person.married = true;
				introService.sendTypedObject(person);
			}
			
			protected function onIntroSendVOResult(event:ResultEvent):void
			{
				currentState = "normal";
				resultStr = String(event.result);
			}	

			protected function wsGetList(event:MouseEvent):void
			{
				ws.getList();
			}
			
			
			protected function onWSGetListResult(event:ResultEvent):void
			{
				currentState = "list";
				var ac:ArrayCollection = event.result as ArrayCollection;
				dg.dataProvider =  ac;
			}
			
			protected function introGetList(event:MouseEvent):void
			{
				introService.getList();
			}
			
			protected function onIntroGetListResult(event:ResultEvent):void
			{
				currentState = "list";
				var ac:ArrayCollection = xmlDecoder.decode(event.result[0] as XML, Person, 
					"getListResponse/getListResult/Person", true, true) as ArrayCollection;
				dg.dataProvider =  ac;
			}
			
			protected function faultHandler(event:FaultEvent):void
			{
				Alert.show(event.fault.faultString, "Error");
			}
			
			private function introduce(p:Person):String
			{
				return "我叫" + p.name + "， 今年" +
					p.age.toString()+ "， " +
					(p.married ? "已婚" : "未婚") + "。";
			}	
		]]>
	</fx:Script>
	
	<s:layout>
		<s:VerticalLayout gap="10" 
			horizontalAlign="center" verticalAlign="middle"/>
	</s:layout>
	
	<s:states>
		<s:State name="normal"/>
		<s:State name="list"/>
	</s:states>
	
	<fx:Declarations>
		
		<s:WebService 
			id="ws"
			wsdl="http://www.riafan.com/services/IntroService.asmx?wsdl"
			fault="faultHandler(event)"> 
			<s:operation name="getTypedObject"
				fault="faultHandler(event)" 
				result="onWSGetVOResult(event)"/> 
			<s:operation name="sendTypedObject"
				fault="faultHandler(event)" 
				result="onWSSendVOResult(event)"/>
			<s:operation name="getList"
				fault="faultHandler(event)" 
				result="onWSGetListResult(event)"/> 
		</s:WebService>
		
		<s:WebService 
			id="introService"
			wsdl="http://www.riafan.com/services/IntroService.asmx?wsdl"
			fault="faultHandler(event)"> 
			<s:operation name="getTypedObject" resultFormat="e4x"
				fault="faultHandler(event)" 
				result="onIntroGetVOResult(event)"/> 
			<s:operation name="sendTypedObject"
				fault="faultHandler(event)" 
				result="onIntroSendVOResult(event)"/>
			<s:operation name="getList" resultFormat="e4x"
				fault="faultHandler(event)" 
				result="onIntroGetListResult(event)"/> 
		</s:WebService>
		
	</fx:Declarations>
	
	<s:Button label="GetTypedObject With SchemaType"
		click="wsGetVO(event)"/>
	
	<s:Button label="GetTypedObject With XmlDecoder"
		click="introGetVO(event)"/>
	
	<s:Button label="Send Typed Object With SchemaType"
		verticalCenter="0" horizontalCenter="0"
		click="wsSendVO(event)"/>
	
	<s:Button label="Send Typed Object With XmlDecoder"
		verticalCenter="0" horizontalCenter="0"
		click="introSendVO(event)"/>
	
	<s:Button label="Get List With SchemaType"
		verticalCenter="0" horizontalCenter="0"
		click="wsGetList(event)"/>
	
	<s:Button label="Get List With XmlDecoder"
		verticalCenter="0" horizontalCenter="0"
		click="wsGetList(event)"/>
	
	<s:Label text="{resultStr}" includeIn="normal"/>
	
	<s:DataGrid id="dg" width="200" includeIn="list">
		<s:columns>
			<s:ArrayList>
				<s:GridColumn dataField="name" headerText="Name"/>
				<s:GridColumn dataField="age" headerText="Age"/>
				<s:GridColumn dataField="married" headerText="Married"/>
			</s:ArrayList>
		</s:columns>
	</s:DataGrid>
	
</s:Application>
