String checkstatus1(int status){
  if (status ==0) {
    return 'ດຳເນີນການ';
  }else if(status==1){
    return 'ສຳເລັດ';
  }else if(status == 2){
    return "ຍົກເລີກ";
  }else{
    return "ດ່ວນ";
  }
}