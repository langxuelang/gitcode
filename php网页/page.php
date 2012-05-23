<?php
header("ContentType:text/html; chartset=utf-8");
require_once('../include/DB.php');
require_once("../include/common.php");
require_once("../include/ssocommon.php");



$sdb = open_sdb();
$sdb->setFetchMode(MDB2_FETCHMODE_ASSOC);


$sql="SELECT count(*) FROM 201104lining_user";
$count = $sdb->queryOne($sql);
$size = 5 ;
$total = ceil($count/$size);
$page = !empty($_GET['page']) ? intval($_GET['page']) : 1;
if($page < 0)
{
   $page = 1;
}else if($page >= 1 && $page <= $total)
{
   $page = $page;
}else
{
   $page = 1;
}

$sql = "SELECT * FROM 201104lining_user order by id limit ".($page-1)*$size.",".$size;
echo $sql;
$list =$sdb->queryAll($sql);

echo '<table cellpadding="10" cellspacing="0" border="0">';
echo '<tr><th>编号</th><th>用户头像</th><th>用户昵称</th></tr>';
foreach($list as $key=>$value)
{
  echo "<tr><td>".$value['id']."</td><td><img src='http://tp3.sinaimg.cn/".$value['sinaid']."/50/5596605601/1'/></td><td>".getuname($value['sinaid'])."</td></tr>";
}
echo "<tr><td colspan=3>".showpage($count,$page,'http://lining.sina.com.cn/irun/interface/page.php')."</td></tr>";
echo "</table>";

function  showpage($count,$page,$url)
{
       $next = 6;
	   $pre  = 6;
	   $sum=ceil($count/$pre); 
	   $p = $page;
	   if($p>=$sum)
	   {
	       $page = $sum;
		   $p = $page;
	   }
	  
	   if($p <=1)
	   {
		   $p = 1;
		   $page= 1;
		   $page_pre = 1;
		   $page_next= $p+1;
	   }else if($p > 1 && $p <= $sum)
	   {
		   $p = $p;
		   $page_pre = $p-1;
		   if($p==$sum)
		   {
		      $page_next= $sum;
			  $this->data["page"] = $sum;
		   }else{
		      $page_next= $p+1;
		   }
		   
	   }else
	   {
		   $p = 1;
		   $page_pre = 1;
		   $page_next= $p+1;
	   }
   
   if(($p-2) < 3)
   {
      $start = 1;
	  $end = 6;
   }else{
      $start = ($p-2);
	  $end = $p+2;
	  if($end>=$sum)
	  {
		  $end = $sum;
	  }
	  $flag = true;
   }
   
   if($end > $sum)
   {
      $start = ($sum-6);
      $end = $sum;
	  $flag = true;
   }
   
   if($flag && $sum > 6)
   {
      $str.="<a href='$url"."?page=1'>1</a>&nbsp;&nbsp;...&nbsp;&nbsp;";
   }
   
   for($i=$start;$i<=$end;$i++)
   {
	  $str.="<a href='$url"."?page=".$i."'>".$i."</a>&nbsp;&nbsp;";
	  if($sum > 6 && $i==$end && $end !=$sum)
	  {
	     $str.="...&nbsp;&nbsp;<a href='$url"."?page=".$sum."'>".$sum."</a>&nbsp;&nbsp;";
	  }
   }
   return $str;
}


function getuname($sinaid)
{
     $sdb = open_sdb();
	 $sdb->setFetchMode(MDB2_FETCHMODE_ASSOC);
	 $sql  = "SELECT * FROM 201104lining_user AS u WHERE sinaid = '".$sinaid."'";
	 $user = $sdb->queryRow($sql);
	 if($user['sinaid'])
	 {
       if($user['sinaname'])
	   {
		  return $user['sinaname'];
	   }
       elseif($user['name'])
	   {
	      return $user['name'];
	   }else{
	      return $sinaid;
	   }
	 }
}



?>