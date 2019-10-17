
accessid = ''
accesskey = ''
host = ''
policyBase64 = ''
signature = ''
callbackbody = ''
filename = ''
key = ''
expire = 0
g_object_name = ''
g_object_name_type = 'random_name'
baseServeUrl = 'http://www.yncyfw.com/common/aliyunOssUpload/getUploadPolicyAndSign';
// baseServeUrl = 'http://interface.xiao2yun.com/commmon/upload/getUploadPolicyAndSign';
now = timestamp = Date.parse(new Date()) / 1000;

function send_request()
{
  var xmlhttp = null;
  if (window.XMLHttpRequest)
  {
    xmlhttp=new XMLHttpRequest();
  }
  else if (window.ActiveXObject)
  {
    xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  }

  if (xmlhttp!=null)
  {
    serverUrl = baseServeUrl;
    xmlhttp.open( "GET", serverUrl, false );
    xmlhttp.send( null );
    return xmlhttp.responseText
  }
  else
  {
    alert("Your browser does not support XMLHTTP.");
  }
};

function check_object_radio() {
  var tt = document.getElementsByName('myradio');
  for (var i = 0; i < tt.length ; i++ )
  {
    if(tt[i].checked)
    {
      g_object_name_type = tt[i].value;
      console.log(tt[i].value)
      break;
    }
  }
}

function get_signature()
{
  //可以判断当前expire是否超过了当前时间,如果超过了当前时间,就重新取一下.3s 做为缓冲
  now = timestamp = Date.parse(new Date()) / 1000;
  if (expire < now + 3)
  {
    body = send_request()
    var obj = eval ("(" + body + ")");
    host = obj['host']
    policyBase64 = obj['policy']
    accessid = obj['accessid']
    signature = obj['signature']
    expire = parseInt(obj['expire'])
    callbackbody = obj['callback']
    key = obj['dir']
    return true;
  }
  return false;
};

function random_string(len) {
  len = len || 32;
  var chars = 'ABCDEFGHJKMNPQRSTWXYZabcdefhijkmnprstwxyz2345678';
  var maxPos = chars.length;
  var pwd = '';
  for (i = 0; i < len; i++) {
    pwd += chars.charAt(Math.floor(Math.random() * maxPos));
  }
  return pwd;
}

function get_suffix(filename) {
  pos = filename.lastIndexOf('.')
  suffix = ''
  if (pos != -1) {
    suffix = filename.substring(pos)
  }
  return suffix;
}

function calculate_object_name(filename)
{
  if (g_object_name_type == 'local_name')
  {
    g_object_name += "${filename}"
  }
  else if (g_object_name_type == 'random_name')
  {
    suffix = get_suffix(filename)
    g_object_name = key + random_string(10) + suffix
  }
  return ''
}

function get_uploaded_object_name(filename)
{
  if (g_object_name_type == 'local_name')
  {
    tmp_name = g_object_name
    tmp_name = tmp_name.replace("${filename}", filename);
    return tmp_name
  }
  else if(g_object_name_type == 'random_name')
  {
    return g_object_name
  }
}

function set_upload_param(up, filename, ret)
{
  if (ret == false)
  {
    ret = get_signature()
  }
  g_object_name = key;
  if (filename != '') { suffix = get_suffix(filename)
    calculate_object_name(filename)
  }
  new_multipart_params = {
    'key' : g_object_name,
    'policy': policyBase64,
    'OSSAccessKeyId': accessid,
    'success_action_status' : '200', //让服务端返回200,不然，默认会返回204
    'callback' : callbackbody,
    'signature': signature,
  };

  up.setOption({
    'url': host,
    'multipart_params': new_multipart_params
  });

  up.start();
}

function uploadFile(options, callback, complete) {
  var filters = {
    mime_types : [ //只允许上传图片和zip文件
      { title : "Image files", extensions : "jpg,gif,png,bmp" },
      { title : "Zip files", extensions : "zip,rar,7z" }
    ],
    max_file_size : max_file_size,
    prevent_duplicates : prevent_duplicates
  };
  if (options.filters) {
    filters = options.filters;
  }
  var openLayer = layer.open({
    type: 1,
    id: 'upload-file-layer',
    title: '上传控件',
    area: ['400px', '310px'],
    content: '<div style="padding:10px 5px 0 5px">'+
			'			<div id="container" style="text-align: center;">'+
			'				<button id="select-files" class="layui-btn"><i class="icon icon-file-o"></i> 选择文件</button>'+
			'				<button id="post-files" class="layui-btn layui-btn-normal"><i class="icon icon-upload"></i> 开始上传</button>'+
			'			</div>'+
			'			<hr style="margin-top: 10px;margin-bottom: 10px;">'+
			'			<p class="text-primary">您所选择的文件：</p>'+
			'			<div id="oss-file"style="min-height: 150px;overflow-y: scroll;max-height: 150px;">你的浏览器不支持flash,Silverlight或者HTML5！</div>'+
			'			<span id="console" class="text-danger" style="color:red;"></span>'+
			'		</div>'
  });

  var options = options;
  var max_file_size = '10mb' // 上传文件的大小
    ,prevent_duplicates = false // 不允许选取重复文件
    ,file_length = 0 // 允许上传文件的个数
    ,multi_selection = true // 是否允许多选
  if (options && options.max_file_size) {
    max_file_size = options.max_file_size;
  }
  if (options && options.prevent_duplicates) {
    prevent_duplicates = options.prevent_duplicates;
  }
  if (options && options.file_length) {
    file_length = options.file_length;
  }

  if (options && !options.multi_selection) {
    multi_selection = options.multi_selection;
  }

  var uploader = new plupload.Uploader({
    runtimes : 'html5,flash,silverlight,html4',
    browse_button : 'select-files',
    multi_selection: multi_selection,
    container: document.getElementById('container'),
    flash_swf_url : 'lib/plupload-2.1.2/js/Moxie.swf',
    silverlight_xap_url : 'lib/plupload-2.1.2/js/Moxie.xap',
    url : 'http://oss.aliyuncs.com',

    filters: filters,

    init: {
      PostInit: function() {
        document.getElementById('oss-file').innerHTML = '';
        document.getElementById('post-files').onclick = function() {
          set_upload_param(uploader, '', false);
          return false;
        };
      },
      FilesAdded: function(up, files) {
        if (file_length) {
          if (uploader.files.length > file_length) {
            layer.msg('只能上传${file_length}个文件');
            return;
          }
        }
        plupload.each(files, function(file) {
          document.getElementById('oss-file').innerHTML += '<div class="file-list" id="' + file.id + '">' + file.name + ' (' + plupload.formatSize(file.size) + ')<small class="text-muted"> <a href="#" class="delete-file text-danger" style="color: #ea644a !important;" data-file-id="' + file.id + '"><i class="icon icon-remove-sign"></i> 删除</a></small>'
            +'<div class="progress" style="height: 15px;width: 100%"><div class="progress-bar progress-bar-info" style="width: 0%"></div></div>'
            +'</div>';
        });
      },

      BeforeUpload: function(up, file) {
        check_object_radio();
        set_upload_param(up, file.name, true);
      },

      UploadProgress: function(up, file) {
        var d = document.getElementById(file.id);
        d.getElementsByTagName('small')[0].innerHTML = '<span>' + file.percent + "%</span>";
        var prog = d.getElementsByTagName('div')[0];
        var progBar = prog.getElementsByTagName('div')[0];
        progBar.style.width= file.percent+'%';
        progBar.setAttribute('aria-valuenow', file.percent);
      },

      FileUploaded: function(up, file, info) {
        if (info.status == 200)
        {
          file.rename = get_uploaded_object_name(file.name);
          callback(up,file,info);
          document.getElementById(file.id).getElementsByTagName('small')[0].innerHTML = '<span class="text-success"> 上传成功</span>';
          // layer.close(openLayer);
//                  document.getElementById(file.id).getElementsByTagName('small')[0].innerHTML = '<span class="text-success"> 上传成功</span>, object name:' + get_uploaded_object_name(file.name);
        }
        else if (info.status == 203)
        {
          document.getElementById(file.id).getElementsByTagName('small')[0].innerHTML = '上传到OSS成功，但是oss访问用户设置的上传回调服务器失败，失败原因是:' + info.response;
        }
        else
        {
          document.getElementById(file.id).getElementsByTagName('small')[0].innerHTML = info.response;
        }
      },
      UploadComplete: function (up, files) {
        if(complete){
          complete(up, files);
        }
        layer.close(openLayer);
      },
      Error: function(up, err) {
        var fileName = err.file.name;
        if (err.code == -600) {
          // document.getElementById('console').appendChild(document.createTextNode("\n文件大小超过限制,请选择"+filters.max_file_size+"以内的照片"));
          document.getElementById('console').innerHTML = '&nbsp;<i class="fa fa-warning"></i> '+fileName+' 文件大小超过限制(' + filters.max_file_size + '以内)';
        }
        else if (err.code == -601) {
          // document.getElementById('console').appendChild(document.createTextNode("\n选择的文件后缀不对,可以根据应用情况，在upload.js进行设置可允许的上传文件类型"));
          document.getElementById('console').innerHTML = '&nbsp;<i class="fa fa-warning"></i> '+fileName+' 文件后缀不对';
        }
        else if (err.code == -602) {
          // document.getElementById('console').appendChild(document.createTextNode("\n这个文件已经上传过一遍了"));
          document.getElementById('console').innerHTML = '&nbsp;<i class="fa fa-warning"></i> '+fileName+' 文件已经上传过一遍了';
        }
        else
        {
          // document.getElementById('console').appendChild(document.createTextNode("\nError xml:" + err.response));
          document.getElementById('console').innerHTML = "\nError xml:" + err.response;
        }
      }
    }
  });

  uploader.init();

  // 文件删除
  $('#oss-file').on('click', '.delete-file', function() {
    var id = $(this).attr('data-file-id');
    var toremove = '';
    for(var i in uploader.files){
      if(uploader.files[i].id === id){
        toremove = i;
      }
    }
    uploader.files.splice(toremove, 1);
    $(this).parents('.file-list').remove();
    return false;
  });
}




