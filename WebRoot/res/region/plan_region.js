var setting = {
			async: {
				enable: true,
				url:"fileCatalog/fcTree",
				type:"get"
			},
			data: {
				simpleData: {
					enable: true
				}
			},
			check:{
				enable: true,
	            chkboxType: {"Y":"s", "N":"ps"}
			},
			callback:{
				oncheck: zTreeOnCheck
			}
		};

	var zNodes =[];
		function zTreeOnCheck(event, treeId, treeNode) {
		    alert(treeNode.tId + ", " + treeNode.name + "," + treeNode.checked);
		};

		$(document).ready(function(){
		
			$.fn.zTree.init($("#treeDemo"), setting, zNodes);
		});