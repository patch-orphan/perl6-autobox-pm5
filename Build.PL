use Module::Build;

my $build = Module::Build->new(
    module_name  => 'Perl6::Autobox',
    license      => 'perl',
    recursive_test_files => 1,
    build_requires => {
        'ok'         => '0.01',
        'Test::More' => '0.40',
    },
    requires => {
        'perl'    => '5.8.0',
        'autobox' => '2.00',
        'parent'  => 0,
    },
    meta_add => {
        resources => {
            homepage   => 'http://github.com/patch/perl6-autobox',
            repository => 'git://github.com/patch/perl6-autobox.git',
        },
    },
);

$build->create_build_script;
