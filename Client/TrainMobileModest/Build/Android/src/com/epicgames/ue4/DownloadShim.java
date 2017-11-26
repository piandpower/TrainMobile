package com.epicgames.ue4;

import com.DeepEye.TrainMobileModest.OBBDownloaderService;
import com.DeepEye.TrainMobileModest.DownloaderActivity;
import android.app.Activity;
import com.google.android.vending.expansion.downloader.Helpers;
import com.DeepEye.TrainMobileModest.OBBData;


public class DownloadShim
{
	public static OBBDownloaderService DownloaderService;
	public static DownloaderActivity DownloadActivity;
	public static Class<DownloaderActivity> GetDownloaderType() { return DownloaderActivity.class; }
	public static boolean expansionFilesDelivered(Activity activity) {
		for (OBBData.XAPKFile xf : OBBData.xAPKS) {
			String fileName = Helpers.getExpansionAPKFileName(activity, xf.mIsMain, xf.mFileVersion);
			GameActivity.Log.debug("Checking for file : " + fileName);
			String fileForNewFile = Helpers.generateSaveFileName(activity, fileName);
			String fileForDevFile = Helpers.generateSaveFileNameDevelopment(activity, fileName);
			GameActivity.Log.debug("which is really being resolved to : " + fileForNewFile + "\n Or : " + fileForDevFile);
			if (Helpers.doesFileExist(activity, fileName, xf.mFileSize, false)) {
				GameActivity.Log.debug("Found OBB here: " + fileForNewFile);
			}
			else if (Helpers.doesFileExistDev(activity, fileName, xf.mFileSize, false)) {
				GameActivity.Log.debug("Found OBB here: " + fileForDevFile);
			}
			else return false;
		}
		return true;
	}
}

