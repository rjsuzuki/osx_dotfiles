import javax.annotation.processing.Processor;

/*
 * Created by Ryan Suzuki 
 */

class MyAnnotationProcessor extends AbstractProcessor {
    
    @Override
    public synchronized void init(ProcessingEnvironment processingEnvironment) {
        super.init(processingEnvironment);
        // initialize helper/utility classes here
        // Filer - genereate files
        // Messager - logging errors/warnings,etc
        // Type - utility methods for OS
    }


    // method where all the processing happens 
    // gives annotations that need to be processed and 
    // roundEnvironment provides the info about the round
    @Override
    public boolean process(Set<? extends TypeElement> annotations,
            RoundEnvironment roundEnvironment) {
        return true;
    }

    @Override
    public Set<String> getSupportedAnnotationTypes() {
        return new HashSet<String>() {{
            add(BindView.class.getCanonicalName());
            add(OnClick.class.getCanonicalName());
        }};
    }

    @Override
    public SourceVersion getSupportedSourceVersion() {
        return SourceVersion.latestSupported();
    }
}

