package example;

import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.basex.query.QueryModule;
import org.basex.server.Log.LogType;

import software.amazon.awssdk.auth.credentials.DefaultCredentialsProvider;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.GetObjectRequest;
import software.amazon.awssdk.services.s3.model.HeadObjectRequest;
import software.amazon.awssdk.services.s3.model.HeadObjectResponse;

/**
 * This class provides a wrapper for AWS SDK
 */
public class AwsS3Facade extends QueryModule {

    private S3Client s3Client;

    /**
     * Constructor requires an AWS region
     * 
     * @param region - region where S3 bucket is located
     */
    public AwsS3Facade(String region) {
        s3Client = buildS3Client(region);
    }

    private S3Client buildS3Client(String region) {
        Region s3Region = Region.of(region);
        return S3Client.builder()
                .region(s3Region)
                .credentialsProvider(DefaultCredentialsProvider.create())
                .build();
    }

    private InputStream getS3Object(String bucketName, String key) {
        GetObjectRequest s3Request = GetObjectRequest.builder().key(key).bucket(bucketName).build();
        return s3Client.getObject(s3Request);
    }

    /**
     * Retrieve a file from an S3 bucket.
     * 
     * @param bucketName      - S3 bucket name
     * @param key             - path for the file in S3
     * @param pathToWriteFile - local file path to write the file
     * @throws Exception
     */
    public void downloadFileFromS3(String bucketName, String key, String pathToWriteFile) throws Exception {
        try (
                OutputStream outputStream = new FileOutputStream(pathToWriteFile);
                BufferedOutputStream writer = new BufferedOutputStream(outputStream);
                InputStream reader = getS3Object(bucketName, key)) {

            queryContext.context.log.write(LogType.INFO,
                    "S3 get file " + key + " from bucket " + bucketName,
                    null, queryContext.context);
            IOUtils.copyLarge(reader, writer);

        }
    }

}