void CRGBView::OnDraw(CDC* pDC)
{
	CRGBDoc* pDoc = GetDocument();
	ASSERT_VALID(pDoc);
	char  filetext[200];
	string R[46][30];//正常
	string G[46][30];
	string B[46][30];
	string RL[46][30];//有光照没影
	string GL[46][30];
	string BL[46][30];
	string RS[46][30];//有光照有影
	string GS[46][30];
	string BS[46][30];

        fstream fs;
        fs.open("rgb.txt");
          int row = 0;
           while(!fs.eof())
             {
                     fs.getline(filetext,200);
					 
						string s(filetext);
						if(s[0]==' '||s[0]=='R'||s[0]=='G'||s[0]=='B')
							 continue;
						stringstream ss;
						for(string::size_type i=0;i!=s.size();i++)
						{
							if(s[i] == ','||s[i]==';')
								s[i]=' ';
						}
						ss<<s;
						
						for(int j=0;j<30;j++)
						{
							
							if(row/46==0)
								ss>>R[row%46][j];
							if(row/46==1)
								ss>>G[row%46][j];
							if(row/46==2)
								ss>>B[row%46][j];
							if(row/46==3)
								ss>>RL[row%46][j];
							if(row/46==4)
								ss>>GL[row%46][j];
							if(row/46==5)
								ss>>BL[row%46][j];
							if(row/46==6)
								ss>>RS[row%46][j];
							if(row/46==7)
								ss>>BS[row%46][j];
							if(row/46==8)
								ss>>BS[row%46][j];
						}
						row++;
                }
      for(int i = 0;i<46;i++)
	  {
		for(int j =0;j<30;j++)
		{
			pDC->SetPixelV(j,i,RGB(atoi(R[i][j].c_str()),atoi(G[i][j].c_str()),atoi(B[i][j].c_str())));
		}
	  }


	   for(i = 0;i<46;i++)
	  {
		for(int j =0;j<30;j++)
		{
			pDC->SetPixelV(j,i+50,RGB(atoi(RL[i][j].c_str()),atoi(GL[i][j].c_str()),atoi(BL[i][j].c_str())));
		}
	  }

	   for(i = 0;i<46;i++)
	  {
		for(int j =0;j<30;j++)
		{
			pDC->SetPixelV(j,i+100,RGB(atoi(RS[i][j].c_str()),atoi(GS[i][j].c_str()),atoi(BS[i][j].c_str())));
		}
	  }
	 
		IplImage * src, *dst ;
	  src = cvCreateImage(cvSize(30,46),8,3);
	  int step = src->widthStep/sizeof(uchar);
	  int height = src->height;
	  char *image1 = new char[height*step];
	  for(i=0;i<46;i++)
	  {
		for(int j = 0;j<30;j++)
		{
			image1[i*step+j*3+2] = atoi(R[i][j].c_str());
			image1[i*step+j*3+1] = atoi(G[i][j].c_str());
			image1[i*step+j*3] = atoi(B[i][j].c_str());
			
		}
	  }
	 
	  src->imageData = image1;
	  cvNamedWindow("Image",1); 

     cvShowImage("Image",src);
     cvWaitKey(0); //等待按键 

     cvDestroyWindow( "Image" );//销毁窗口
     cvReleaseImage( &src ); //释放图像 

	// TODO: add draw code for native data here
}
