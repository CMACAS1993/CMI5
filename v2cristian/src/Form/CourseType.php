<?php

namespace App\Form;

use App\Entity\Course;
use App\Entity\User;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\DateTimeType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class CourseType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('name', TextType::class, array('label' => 'Nombre', 'attr' => array('class' => 'form_control')))
            ->add('initialDate', DateTimeType::class, array('label' => 'Fecha Inicio', 'html5' => false, 'required' => true, 'format' => 'dd/MM/yyyy', 'widget' => 'single_text', 'attr' => array('class' => 'form-control', 'placeholder' => 'MM/dd/yyyy')))
            ->add('finalDate', DateTimeType::class, array('label' => 'Fecha Fin', 'html5' => false, 'required' => true, 'format' => 'dd/MM/yyyy', 'widget' => 'single_text', 'attr' => array('class' => 'form-control', 'placeholder' => 'MM/dd/yyyy')))
            ->add('members', EntityType::class, array(
                'label' => 'Miembros',
                'class' => User::class,
                'expanded' => false,
                'multiple' => true,
                'attr' => array('class' => ''),
                'required'=>false,
            ))
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Course::class,
        ]);
    }
}
