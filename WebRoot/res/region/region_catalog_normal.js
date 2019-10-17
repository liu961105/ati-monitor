var setting = {
			async: {
				enable: true,
				url:"fileCatalog/fcNormalTree",
				type:"get",
				dataFilter: filter
			},
			view: {
				/*addHoverDom: addHoverDom,
				removeHoverDom: removeHoverDom,
				dblClickExpand: dblClickExpand,
				selectedMulti: false,
				fontCss: setFontCss*/
			},
			/*edit: {
				enable: true,
				editNameSelectAll: true,
				drag: {
					isCopy:false,
					isMove:false
				},
				showRemoveBtn: showRemoveBtn,
				renameTitle:'重命名',
				removeTitle:"删除部门",
				showRenameBtn: showRenameBtn
			},*/
			data: {
				simpleData: {
					enable: true
				}
			},
			callback: {
				//beforeDrag: beforeDrag,
				//beforeDrop: beforeDrop,
				//beforeEditName: beforeEditName,				
				//beforeRemove: beforeRemove,
				//beforeRename: beforeRename,
				//onClick: onClick,
				//onRemove: zTreeOnRemove
			}
		};

	var zNodes =[];
		var log, className = "dark";
		function dblClickExpand(treeId, treeNode) {
			return treeNode.level > 0;
		}
		
		//treeId是normalCatalogTree 
		function filter(treeId, parentNode, childNodes) { 
			if (!childNodes) return null; 
			for (var i=0, l=childNodes.length; i<l; i++) { 
				childNodes[i].name = childNodes[i].name.replace('',''); 
				if(childNodes[i].isFile && childNodes[i].isFile=="1"){
					childNodes[i].icon = "res/img/manage/file-flag.png";
				}
			} 
			return childNodes; 
		} 
		$(document).ready(function(){
			//$("#normalCatalogTree").height(400);//-20
			$.fn.zTree.init($("#normalCatalogTree"), setting, zNodes);
		});